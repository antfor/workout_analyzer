create or replace function import_workouts(
  _user uuid,
  _workouts jsonb,
  _exercises jsonb,
  _cardio jsonb
)
returns void
language plpgsql
security definer
as $$
begin
  -- Start a transaction-like lock to prevent concurrent imports
  perform pg_advisory_xact_lock(hashtext(_user::text));

  -- 1. Delete old data for this user
  delete from lift where user_id = _user;
  delete from cardio where user_id = _user;
  delete from workout where user_id = _user;

  -- 2. Insert workouts
  insert into workout (user_id, title, start_time, end_time)
  select
    _user,
    (w ->> 'id')::int, 
    w->>'title',
    (w->>'start_time')::timestamptz,
    (w->>'end_time')::timestamptz
  from jsonb_array_elements(_workouts) as w;

  -- 3. Insert exercises
  insert into lift (user_id, exercise, set_of_sets, set_index, reps, weight_kg, workout)
  select
    _user,
    e->>'exercise',
    (e->>'set_of_sets')::int,
    (e->>'set_index')::int,
    (e->>'reps')::int,
    (e->>'weight_kg')::float,
    (e->>'workout')::uuid
  from jsonb_array_elements(_exercises) as e;

  -- 4. Insert cardio
  insert into cardio (user_id, exercise, lap, distance_m, duration_s, workout)
  select
    _user,
    c->>'exercise',
    (c->>'lap')::int,
    (c->>'distance_m')::float,
    (c->>'duration_s')::int,
    (c->>'workout')::uuid
  from jsonb_array_elements(_cardio) as c;

end;
$$;


create or replace function get_updates(_user uuid, _since timestamptz)
returns jsonb
language plpgsql
as $$
declare
  result jsonb;
begin
  result := jsonb_build_object(
    'workout', (
      select jsonb_agg(row_to_json(t))
      from workout t
      where user_id = _user
      and (updated_at > _since or deleted_at > _since)
    ),
    'lift', (
      select jsonb_agg(row_to_json(t))
      from lift t
      where user_id = _user
      and (updated_at > _since or deleted_at > _since)
    ),
    'cardio', (
      select jsonb_agg(row_to_json(t))
      from cardio t
      where user_id = _user
      and (updated_at > _since or deleted_at > _since)
    )
  );

  return result;
end;
$$;


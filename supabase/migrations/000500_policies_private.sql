-- workouts
create policy "user can read own or mock workouts"
  on private.workouts
  for select
  using (
    (SELECT auth.uid()) = user_id
    OR (SELECT (SELECT auth.jwt())) ->> 'role' = 'mock'
  );

create policy "user can insert own workouts"
  on private.workouts
  for insert
  with check ((SELECT auth.uid()) = user_id);

create policy "user can update own workouts"
  on private.workouts
  for update
  using ((SELECT auth.uid()) = user_id)
  with check ((SELECT auth.uid()) = user_id);

create policy "user can delete own workouts"
  on private.workouts
  for delete
  using ((SELECT auth.uid()) = user_id);

-- lift
create policy "user can read own or mock lifts"
  on private.lift
  for select
  using (
    (SELECT auth.uid()) = user_id
    OR (SELECT auth.jwt()) ->> 'role' = 'mock'
  );

create policy "user can insert own lift"
  on private.lift
  for insert
  with check ((SELECT auth.uid()) = user_id);

create policy "user can update own lift"
  on private.lift
  for update
  using ((SELECT auth.uid()) = user_id)
  with check ((SELECT auth.uid()) = user_id);

create policy "user can delete own lift"
  on private.lift
  for delete
  using ((SELECT auth.uid()) = user_id);

-- cardio
create policy "user can read own or mock cardio"
  on private.cardio
  for select
  using (
    (SELECT auth.uid()) = user_id
    OR (SELECT auth.jwt()) ->> 'role' = 'mock'
  );

create policy "user can insert own cardio"
  on private.cardio
  for insert
  with check ((SELECT auth.uid()) = user_id);

create policy "user can update own cardio"
  on private.cardio
  for update
  using ((SELECT auth.uid()) = user_id)
  with check ((SELECT auth.uid()) = user_id);

create policy "user can delete own cardio"
  on private.cardio
  for delete
  using ((SELECT auth.uid()) = user_id);
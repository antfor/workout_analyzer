-- workouts
create policy "user can read own or mock workouts"
  on private.workouts
  for select
  using (private.can_read_user_data(user_id));

create policy "user can insert own workouts"
  on private.workouts
  for insert
  with check (private.can_write_user_data(user_id));

create policy "user can update own workouts"
  on private.workouts
  for update
  using (private.can_write_user_data(user_id))
  with check (private.can_write_user_data(user_id));

create policy "user can delete own workouts"
  on private.workouts
  for delete
  using (private.can_write_user_data(user_id));

-- lift
create policy "user can read own or mock lifts"
  on private.lift
  for select
  using (private.can_read_user_data(user_id));

create policy "user can insert own lift"
  on private.lift
  for insert
  with check (private.can_write_user_data(user_id));

create policy "user can update own lift"
  on private.lift
  for update
  using (private.can_write_user_data(user_id))
  with check (private.can_write_user_data(user_id));

create policy "user can delete own lift"
  on private.lift
  for delete
  using (private.can_write_user_data(user_id));

-- cardio
create policy "user can read own or mock cardio"
  on private.cardio
  for select
  using (private.can_read_user_data(user_id));

create policy "user can insert own cardio"
  on private.cardio
  for insert
  with check (private.can_write_user_data(user_id));

create policy "user can update own cardio"
  on private.cardio
  for update
  using (private.can_write_user_data(user_id))
  with check (private.can_write_user_data(user_id));

create policy "user can delete own cardio"
  on private.cardio
  for delete
  using (private.can_write_user_data(user_id));
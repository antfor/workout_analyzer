-- exercises
create policy "public read exercises"
  on public.exercises
  for select
  using (true);

create policy "admin insert exercises"
  on public.exercises
  for insert
  with check ((SELECT auth.role()) = 'admin');

create policy "admin update exercises"
  on public.exercises
  for update
  using ((SELECT auth.role()) = 'admin')
  with check ((SELECT auth.role()) = 'admin');

create policy "admin delete exercises"
  on public.exercises
  for delete
  using ((SELECT auth.role()) = 'admin');

-- equipment
create policy "public read equipment"
  on public.equipment
  for select
  using (true);

create policy "admin insert equipment"
  on public.equipment
  for insert
  with check ((SELECT auth.role()) = 'admin');

create policy "admin update equipment"
  on public.equipment
  for update
  using ((SELECT auth.role()) = 'admin')
  with check ((SELECT auth.role()) = 'admin');

create policy "admin delete equipment"
  on public.equipment
  for delete
  using ((SELECT auth.role()) = 'admin');

-- muscle
create policy "public read muscle"
  on public.muscle
  for select
  using (true);

create policy "admin insert muscle"
  on public.muscle
  for insert
  with check ((SELECT auth.role()) = 'admin');

create policy "admin update muscle"
  on public.muscle
  for update
  using ((SELECT auth.role()) = 'admin')
  with check ((SELECT auth.role()) = 'admin');

create policy "admin delete muscle"
  on public.muscle
  for delete
  using ((SELECT auth.role()) = 'admin');

-- standardsweight
create policy "public read standardsweight"
  on public.standardsweight
  for select
  using (true);

create policy "admin insert standardsweight"
  on public.standardsweight
  for insert
  with check ((SELECT auth.role()) = 'admin');

create policy "admin update standardsweight"
  on public.standardsweight
  for update
  using ((SELECT auth.role()) = 'admin')
  with check ((SELECT auth.role()) = 'admin');

create policy "admin delete standardsweight"
  on public.standardsweight
  for delete
  using ((SELECT auth.role()) = 'admin');

-- standardsreps
create policy "public read standardsreps"
  on public.standardsreps
  for select
  using (true);

create policy "admin insert standardsreps"
  on public.standardsreps
  for insert
  with check ((SELECT auth.role()) = 'admin');

create policy "admin update standardsreps"
  on public.standardsreps
  for update
  using ((SELECT auth.role()) = 'admin')
  with check ((SELECT auth.role()) = 'admin');

create policy "admin delete standardsreps"
  on public.standardsreps
  for delete
  using ((SELECT auth.role()) = 'admin');

-- standardscardio
create policy "public read standardscardio"
  on public.standardscardio
  for select
  using (true);

create policy "admin insert standardscardio"
  on public.standardscardio
  for insert
  with check ((SELECT auth.role()) = 'admin');

create policy "admin update standardscardio"
  on public.standardscardio
  for update
  using ((SELECT auth.role()) = 'admin')
  with check ((SELECT auth.role()) = 'admin');

create policy "admin delete standardscardio"
  on public.standardscardio
  for delete
  using ((SELECT auth.role()) = 'admin');





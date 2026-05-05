CREATE SCHEMA internal;

-- roles catalog
create table internal.roles (
  id text primary key
);

insert into internal.roles (id) values ('admin'), ('mock');

create table internal.user_roles (
  user_id uuid references auth.users,
  role_id text references internal.roles(id),
  primary key (user_id, role_id)
);

create unique index one_mock_only
    on internal.user_roles (role_id)
    where role_id = 'mock';

create index on internal.user_roles (user_id, role_id);

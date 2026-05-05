
create function internal.is_role_user(_user_id uuid, _role text)
returns boolean
language sql
stable
set search_path = public, pg_catalog
security definer
as $$
  select exists (
    select 1
    from internal.user_roles
    where user_id = _user_id
      and role_id = _role
  );
$$;

revoke execute on function internal.is_role_user(uuid, text) from anon, authenticated;

create function internal.is_admin()
returns boolean
language sql
stable
set search_path = public, pg_catalog
as $$
  select internal.is_role_user(auth.uid(), 'admin');
$$;


create function public.is_owner(_user_id uuid)
returns boolean
language sql
stable
set search_path = public, pg_catalog
as $$
  select auth.uid() = _user_id;
$$;

-- READ WRITE

create function private.can_read_user_data(_user_id uuid)
returns boolean
language sql
stable
set search_path = public, pg_catalog
as $$
  select
    public.is_owner(_user_id)
    OR internal.is_role_user(_user_id, 'mock');
$$;

create function private.can_write_user_data(_user_id uuid)
returns boolean
language sql
stable
set search_path = public, pg_catalog
as $$
  select public.is_owner(_user_id);
$$;

create function internal.is_role_user(_user_id uuid, _role text)
returns boolean
language sql
stable
SET search_path = ''
security definer
as $$
  select exists (
    select 1
    from internal.user_roles
    where user_id = _user_id
      and role_id = _role
  );
$$;

revoke execute on function internal.is_role_user(uuid, text) from PUBLIC,anon, authenticated;

create function internal.is_admin()
returns boolean
language sql
stable
SET search_path = ''
as $$
  select internal.is_role_user(auth.uid(), 'admin');
$$;

revoke execute on function internal.is_admin() from PUBLIC,anon, authenticated;

create function public.is_owner(_user_id uuid)
returns boolean
language sql
stable
SET search_path = ''
as $$
  select auth.uid() = _user_id;
$$;

-- READ WRITE

create function private.can_read_user_data(_user_id uuid)
returns boolean
language sql
stable
SET search_path = ''
as $$
  select
    (public.is_owner(_user_id) 
    OR internal.is_role_user(_user_id, 'mock')
    );
$$;

revoke execute on function private.can_read_user_data(uuid) from PUBLIC, anon;

create function private.can_write_user_data(_user_id uuid)
returns boolean
language sql
stable
SET search_path = ''
as $$
  select public.is_owner(_user_id);
$$;

revoke execute on function private.can_write_user_data(uuid) from PUBLIC, anon;
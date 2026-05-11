--internal

REVOKE ALL ON SCHEMA internal FROM anon, authenticated, public;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA internal FROM anon, authenticated, public;
REVOKE ALL ON ALL TABLES IN SCHEMA internal FROM PUBLIC, anon, authenticated;

alter table internal.roles enable row level security;
alter table internal.user_roles enable row level security;

REVOKE all ON internal.roles FROM anon, authenticated;
REVOKE all ON internal.user_roles FROM anon, authenticated;

--public: exercises,equipment,muscle,standardsweight,standardsreps,standardscardio

alter table public.exercises enable row level security;
alter table public.equipment enable row level security;
alter table public.muscle enable row level security;

alter table public.standardsweight enable row level security;
alter table public.standardsreps enable row level security;
alter table public.standardscardio enable row level security;

--REVOKE GraphQL acces

REVOKE SELECT ON public.exercises FROM anon, authenticated;
REVOKE SELECT ON public.equipment FROM anon, authenticated;
REVOKE SELECT ON public.muscle FROM anon, authenticated;

REVOKE SELECT ON public.standardsweight FROM anon, authenticated;
REVOKE SELECT ON public.standardsreps FROM anon, authenticated;
REVOKE SELECT ON public.standardscardio FROM anon, authenticated;

--private: lift,cardio,workouts,

alter table private.lift enable row level security;
alter table private.cardio enable row level security;
alter table private.workouts enable row level security;
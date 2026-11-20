-- Run this once in Supabase: SQL Editor -> New query -> paste -> Run.

create table if not exists rehab_exercises (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users on delete cascade,
  name text not null,
  description text not null default '',
  sets_target int not null default 3,
  reps_min int not null default 8,
  reps_max int not null default 12,
  uses_weight boolean not null default false,
  rest_seconds int not null default 60,
  sort_order int not null default 0,
  archived boolean not null default false,
  created_at timestamptz not null default now()
);

create table if not exists rehab_workouts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users on delete cascade,
  date date not null,
  note text not null default '',
  feel smallint check (feel between 1 and 5),
  created_at timestamptz not null default now(),
  unique (user_id, date)
);

create table if not exists rehab_set_logs (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users on delete cascade,
  workout_id uuid not null references rehab_workouts on delete cascade,
  exercise_id uuid not null references rehab_exercises on delete cascade,
  set_number int not null,
  reps int not null,
  weight numeric(6,2),
  created_at timestamptz not null default now()
);
create index if not exists rehab_set_logs_workout_idx on rehab_set_logs (workout_id);
create index if not exists rehab_set_logs_exercise_idx on rehab_set_logs (exercise_id);

-- Row Level Security: the anon key is public on GitHub Pages, so this is what keeps your data private.
alter table rehab_exercises enable row level security;
alter table rehab_workouts  enable row level security;
alter table rehab_set_logs  enable row level security;

create policy "own rows" on rehab_exercises for all to authenticated using (user_id = auth.uid()) with check (user_id = auth.uid());
create policy "own rows" on rehab_workouts  for all to authenticated using (user_id = auth.uid()) with check (user_id = auth.uid());
create policy "own rows" on rehab_set_logs  for all to authenticated using (user_id = auth.uid()) with check (user_id = auth.uid());

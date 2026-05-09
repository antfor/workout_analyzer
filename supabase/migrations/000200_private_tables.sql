CREATE SCHEMA private;

CREATE TABLE private.workouts(
    user_id uuid REFERENCES auth.users(id),
    id uuid NOT NULL,
    title TEXT NOT NULL,
    start_time TIMESTAMPTZ NOT NULL,
    end_time TIMESTAMPTZ NOT NULL,

    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now(),
    deleted_at TIMESTAMPTZ,

    PRIMARY KEY (user_id, id),

    CHECK (start_time <= end_time)
);


CREATE TABLE private.lift(
    user_id uuid REFERENCES auth.users(id),
    exercise TEXT NOT NULL REFERENCES public.exercises (id),
    set_of_sets INT NOT NULL, -- you can do benchpress at start and end of workout for example
    set_index INT NOT NULL,
    reps INT NOT NULL,
    weight_kg FLOAT, --TODO replace with NUMERIC(6,2)?
    workout uuid NOT NULL,

    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now(),
    deleted_at TIMESTAMPTZ,

    PRIMARY KEY (user_id, workout, exercise, set_of_sets, set_index),
    FOREIGN KEY(user_id, workout) REFERENCES private.workouts(user_id, id) ON DELETE CASCADE,

    CHECK (reps > 0),
    CHECK (set_index >= 0),
    CHECK (set_of_sets > 0)
);

CREATE INDEX lift_id_workout
ON private.lift(user_id, workout);

CREATE TABLE private.cardio(
    user_id uuid REFERENCES auth.users(id),
    exercise TEXT NOT NULL REFERENCES public.exercises (id),
    lap INT NOT NULL, --TODO lap_of_laps
    distance_m FLOAT, 
    duration_s FLOAT,
    workout uuid NOT NULL,

    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now(),
    deleted_at TIMESTAMPTZ,

    PRIMARY KEY (user_id, workout, exercise, lap),
    FOREIGN KEY(user_id, workout) REFERENCES private.workouts(user_id, id) ON DELETE CASCADE,

    CHECK (lap >= 0),
    CHECK ((distance_m IS NULL AND duration_s IS NOT NULL) OR distance_m > 0),
    CHECK ((duration_s IS NULL AND distance_m IS NOT NULL) OR duration_s > 0)
);

CREATE INDEX cardio_id_workout
ON private.cardio(user_id, workout);

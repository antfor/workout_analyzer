CREATE TABLE public.muscle(
    id TEXT NOT NULL PRIMARY KEY
);

CREATE TABLE public.equipment(
    id TEXT NOT NULL PRIMARY KEY,

    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now(),
    deleted_at TIMESTAMPTZ
);

CREATE TABLE public.exercises(
    id TEXT NOT NULL PRIMARY KEY,
    muscle TEXT NOT NULL REFERENCES public.muscle(id),
    equipment TEXT REFERENCES public.equipment(id),

    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now(),
    deleted_at TIMESTAMPTZ
);

CREATE TABLE public.standardsweight(
    exercise TEXT NOT NULL REFERENCES public.exercises (id),
    sex TEXT NOT NULL,
    bodyweight FLOAT NOT NULL,
    beginner FLOAT NOT NULL,
    novice FLOAT NOT NULL,
    intermediate FLOAT NOT NULL,
    advanced FLOAT NOT NULL,
    elite FLOAT NOT NULL,

    PRIMARY KEY (exercise, sex, bodyweight),

    CHECK (sex in ('male','female')), 

    CHECK (beginner >= 0),
    CHECK (novice >= beginner),
    CHECK (intermediate >= novice),
    CHECK (advanced >= intermediate),
    CHECK (elite >= advanced)

);

CREATE TABLE public.standardsreps(
    exercise TEXT NOT NULL REFERENCES public.exercises (id),
    sex TEXT NOT NULL,
    bodyweight FLOAT NOT NULL,
    beginner INT NOT NULL,
    novice INT NOT NULL,
    intermediate INT NOT NULL,
    advanced INT NOT NULL,
    elite INT NOT NULL,

    PRIMARY KEY (exercise, sex, bodyweight),

    CHECK (sex in ('male','female')), 

    CHECK (beginner >= 0),
    CHECK (novice >= beginner),
    CHECK (intermediate >= novice),
    CHECK (advanced >= intermediate),
    CHECK (elite >= advanced)
);

CREATE TABLE public.standardscardio(
    exercise TEXT NOT NULL REFERENCES public.exercises (id),
    sex TEXT NOT NULL,
    age INT NOT NULL,
    distance_m FLOAT NOT NULL,

    beginner FLOAT NOT NULL,
    novice FLOAT NOT NULL,
    intermediate FLOAT NOT NULL,
    advanced FLOAT NOT NULL,
    elite FLOAT NOT NULL,

    PRIMARY KEY (exercise, sex, age),

    CHECK (sex in ('male','female')), 
    CHECK (age >= 0),

    CHECK (beginner >= 0),
    CHECK (novice >= beginner),
    CHECK (intermediate >= novice),
    CHECK (advanced >= intermediate),
    CHECK (elite >= advanced)
);
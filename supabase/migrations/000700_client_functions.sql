


CREATE OR REPLACE FUNCTION public.import_user_data(workout_items jsonb, lift_items jsonb, cardio_items jsonb)
RETURNS timestamptz
LANGUAGE plpgsql
SECURITY definer
SET search_path = ''
AS $$
DECLARE
    v_user_id uuid;
    v_now timestamptz := now();
BEGIN
    v_user_id := auth.uid();

    IF v_user_id IS NULL THEN
        RAISE EXCEPTION 'Unauthenticated';
    END IF;

    IF NOT private.can_write_user_data(v_user_id) THEN
        RAISE EXCEPTION 'Unauthorized';
    END IF;

    PERFORM pg_advisory_xact_lock(hashtextextended(v_user_id::TEXT, 0));

    DELETE FROM private.workouts WHERE user_id = v_user_id;
    DELETE FROM private.lift WHERE user_id = v_user_id;
    DELETE FROM private.cardio WHERE user_id = v_user_id;

    -- Insert Workouts
    INSERT INTO private.workouts(user_id, id, title, start_time, end_time) 
    SELECT 
        v_user_id, id, title, start_time, end_time
    FROM jsonb_to_recordset(workout_items) AS item(
        id uuid,
        title TEXT,
        start_time TIMESTAMPTZ,
        end_time TIMESTAMPTZ
    );

    -- Insert Lifts
    INSERT INTO private.lift(user_id, exercise, set_of_sets, set_index, reps, weight_kg, workout) 
    SELECT 
        v_user_id, exercise, set_of_sets, set_index, reps, weight_kg, workout
    FROM jsonb_to_recordset(lift_items) AS item(
        exercise TEXT,
        set_of_sets INT,
        set_index INT,
        reps INT,
        weight_kg FLOAT,
        workout uuid
    );

    -- Insert Cardio
    INSERT INTO private.cardio (user_id, exercise, lap, distance_m, duration_s, workout) 
    SELECT 
        v_user_id, exercise, lap, distance_m, duration_s, workout
    FROM jsonb_to_recordset(cardio_items) AS item(
        exercise TEXT,
        lap INT,
        distance_m FLOAT, 
        duration_s FLOAT,
        workout uuid
    );

    RETURN v_now;
END;
$$;

REVOKE EXECUTE
ON FUNCTION public.import_user_data(jsonb,jsonb,jsonb)
FROM anon;

GRANT EXECUTE
ON FUNCTION public.import_user_data(jsonb,jsonb,jsonb)
TO authenticated;

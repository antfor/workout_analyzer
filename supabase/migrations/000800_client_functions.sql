

/*
--TODO private function only exposed to loged in users
CREATE OR REPLACE FUNCTION private.import_user_data(workout_items jsonb, lift_items jsonb, cardio_items jsonb)
RETURNS timestamptz
LANGUAGE plpgsql
AS $$
DECLARE
    v_user_id uuid;
    v_now timestamptz;
BEGIN
    v_user_id := auth.uid();

    IF v_user_id IS NULL THEN
        RAISE EXCEPTION 'Unauthenticated';
    END IF;

    v_now := internal.import_user_data(workout_items jsonb, lift_items jsonb, cardio_items jsonb);

    RETURN v_now;
END;
$$;

GRANT EXECUTE ON FUNCTION private.import_user_data_rpc TO authenticated;


--TODO internal function not exposed to client
CREATE OR REPLACE FUNCTION internal.import_user_data(workout_items jsonb, lift_items jsonb, cardio_items jsonb)
RETURNS timestamptz
LANGUAGE SQL
AS $$
    WITH 
        server_time AS (SELECT now() AS st), 
        auth_id AS (SELECT auth.uid() AS user_id),
        user_lock AS (SELECT pg_advisory_xact_lock(hashtextextended((SELECT user_id FROM auth_id)::TEXT, 0))), 

        delete_workout AS (DELETE FROM private.workouts WHERE user_id = (SELECT user_id FROM auth_id)),

        insert_workout AS (INSERT INTO private.workouts(user_id, id, title, start_time, end_time) 
            SELECT 
                cu.user_id, id, title, start_time, end_time
            FROM auth_id AS cu, jsonb_to_recordset(workout_items)
                AS item(
                    id uuid,
                    title TEXT,
                    start_time TIMESTAMPTZ,
                    end_time TIMESTAMPTZ
                )), 

        insert_lift AS (INSERT INTO private.lift(user_id, exercise, set_of_sets, set_index, reps, weight_kg, workout) 
            SELECT 
                cu.user_id, exercise, set_of_sets, set_index, reps, weight_kg, workout
            FROM auth_id AS cu, jsonb_to_recordset(lift_items) AS item(
                exercise TEXT,
                set_of_sets INT,
                set_index INT,
                reps INT,
                weight_kg FLOAT,
                workout uuid
            )), 

        insert_cardio AS (INSERT INTO private.cardio (user_id, exercise, lap, distance_m, duration_s, workout) 
            SELECT 
                cu.user_id, exercise, lap, distance_m, duration_s, workout
            FROM auth_id AS cu, jsonb_to_recordset(cardio_items) AS item(
                exercise TEXT,
                lap INT,
                distance_m FLOAT, 
                duration_s FLOAT,
                workout uuid
            ))
    SELECT st FROM server_time;
$$;

REVOKE EXECUTE ON FUNCTION internal.import_user_data(jsonb, jsonb, jsonb) FROM anon, authenticated;
*/

CREATE OR REPLACE FUNCTION import_new_data(workout_items jsonb, lift_items jsonb, cardio_items jsonb)
RETURNS timestamptz
LANGUAGE SQL
AS $$
    WITH 
        server_time AS (SELECT now()), 
        current_user AS (SELECT auth.uid() AS user_id),
        user_lock AS (SELECT pg_advisory_xact_lock(hashtextextended(current_user::TEXT, 0))), 

        delete_workout AS (DELETE FROM private.workouts WHERE current_user = user_id),

        insert_workout AS (INSERT INTO private.workouts(user_id, id, title, start_time, end_time) 
            SELECT 
                current_user,
                (item ->> 'id')::INT,
                (item ->> 'title')::TEXT, 
                (item ->> 'start_time')::TIMESTAMPTZ,
                (item ->> 'end_time')::TIMESTAMPTZ
            FROM jsonb_array_elements(workout_items) AS item), 

        insert_lift AS (INSERT INTO private.lift(user_id, exercise, set_of_sets, set_index, reps, weight_kg, workout) 
            SELECT 
                current_user,
                (item ->> 'exercise')::TEXT, 
                (item ->> 'set_of_sets')::INT, 
                (item ->> 'set_index')::INT, 
                (item ->> 'reps')::INT, 
                (item ->> 'weight_kg')::FLOAT, 
                (item ->> 'workout')::INT
            FROM jsonb_array_elements(lift_items) AS item), 

        insert_cardio AS (INSERT INTO private.cardio (user_id, exercise, lap, distance_m, duration_s, workout) 
            SELECT 
                current_user,
                (item ->> 'exercise')::TEXT, 
                (item ->> 'lap')::INT, 
                (item ->> 'distance_m')::FLOAT, 
                (item ->> 'duration_s')::FLOAT, 
                (item ->> 'workout')::INT
            FROM jsonb_array_elements(cardio_items) AS item),
    SELECT server_time;
$$;

/*TODO use jsonb_to_recordset(workout_items)
AS x(
    id int,
    title text,
    start_time timestamptz,
    end_time timestamptz
)
*/
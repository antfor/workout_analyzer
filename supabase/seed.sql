--Muscle
INSERT INTO public.muscle (id) VALUES
    ('Cardio'),
    ('Full Body'),
    ('Abductors'),
    ('Adductors'),
    ('Abdominals'),
    ('Biceps'),
    ('Calves'),
    ('Chest'),
    ('Forearms'),
    ('Glutes'),
    ('Hamstrings'),
    ('Lats'),
    ('Lower Back'),
    ('Neck'),
    ('Quadriceps'),
    ('Triceps'),
    ('Tibialis'),
    ('Serratus'),
    ('Obliques'),
    ('Upper Back'), --TODO remove
    ('Traps'),
    ('Teres'),
    ('Shoulders'), --TODO remove
    ('Front Delts'),
    ('Side Delts'),
    ('Rear Delts'),
    ('Other');

--Exercises

INSERT INTO public.exercises (id, muscle) VALUES
    ('Bench Press (Barbell)','Chest'),
    ('Bench Press - Close Grip (Barbell)','Triceps'),
    ('Bent Over Row (Barbell)','Upper Back'),
    ('Bicep Curl (Barbell)','Biceps'),
    ('Bicep Curl (Dumbbell)','Biceps'),
    ('Chin Up','Lats'),
    ('Dead Hang','Upper Back'),
    ('Deadlift (Barbell)','Glutes'),
    ('Decline Crunch (Weighted)','Abdominals'),
    ('EZ Bar Biceps Curl','Biceps'),
    ('Hammer Curl (Dumbbell)','Biceps'),
    ('Incline Bench Press (Barbell)','Chest'),
    ('JM Press (Barbell)','Triceps'),
    ('Lateral Raise (Dumbbell)','Side Delts'),
    ('Lying Neck Curls (Weighted)','Neck'),
    ('Lying Neck Extension (Weighted)','Neck'),
    ('Overhead Press (Barbell)','Front Delts'),
    ('Overhead Press (Dumbbell)','Front Delts'),
    ('Reverse Curl (Barbell)','Biceps'),
    ('Reverse Curl (Dumbbell)','Biceps'),
    ('Romanian Deadlift (Barbell)','Hamstrings'),
    ('Seated Palms Up Wrist Curl','Forearms'),
    ('Seated Wrist Extension (Barbell)','Forearms'),
    ('Shrug (Barbell)','Traps'),
    ('Shrug (Dumbbell)','Traps'),
    ('Side Bend (Dumbbell)','Obliques'),
    ('Skullcrusher (Barbell)','Triceps'),
    ('Skullcrusher (Dumbbell)','Triceps'),
    ('Goblet Squat','Quadriceps'),
    ('Squat (Barbell)','Quadriceps'),
    ('Standing Calf Raise (Barbell)','Calves'),
    ('Standing Calf Raise (Dumbbell)','Calves'),
    ('Pull Up','Lats'),
    ('Pull Up (Weighted)','Lats'),
    ('Skiing','Cardio'),
    ('Walking','Cardio'),
    ('Cycling','Cardio'),
    ('Running','Cardio');


--Equipment
INSERT INTO public.equipment (id) VALUES
    ('Assisted'),
    ('Cable'),
    ('Dumbbell'),
    ('Barbell'),
    ('Machine'),
    ('Smith Machine'),
    ('Weighted'),
    ('Bodyweight');

--Standards
--  standardsweight
--  standardsreps
--  standardscardio



//"tibialis", "front delt", "rear delt", "side delt","obliques"
enum Muscle{
  
  cardio("Cardio"),
  fullBody("Full Body"),
  
  abductors("Abductors"),
  adductors("Adductors"),
  abdominals("Abdominals"),
  biceps("Biceps"),
  calves("Calves"),
  chest("Chest"),
  forearms("Forearms"),
  glutes("Glutes"),
  hamstrings("Hamstrings"),
  lats("Lats"),
  lowerBack("Lower Back"),
  neck("Neck"),
  quadriceps("Quadriceps"),
  shoulders("Shoulders"),
  traps("Traps"),
  triceps("Triceps"),
  upperBack("Upper Back"),
  
  other("Other");

  final String string;

  const Muscle(this.string);

  static Muscle fromString(String s){
    return Muscle.values.firstWhere((m)=> cmpS(m.string,s), orElse: () => Muscle.other);
  }
}

bool cmpS(String a, String b){
  return a.toLowerCase().trim() == b.toLowerCase().trim();
}

enum Equipment{
  assisted("Assisted"),
  cable("Cable"),
  dumbbell("Dumbbell"),
  barbell("Barbell"),
  machine("Machine"),
  smithMachine("Smith Machine"),
  weighted("Weighted"),
  bodyweight("Bodyweight");

  final String string;
  const Equipment(this.string);
}
/*
//
 "Abdominals", "Biceps", "Triceps", "Chest", "Shoulders",
    "Lower Back","Upper Back",, "Lats", "Traps", "Forearms",
    "Quadriceps", "Hamstrings", "Glutes", "Calves",
    "Adductors", "Abductors", "Neck",
    "Cardio", "Full Body", "Other"

//not added
    "tibialis", "front delt", "rear delt", "side delt","obliques"
*/


/* Eqipmenrt

Assisted, Cable, Dumbbell, Barbell, Machine, Smith Machine, Weighted
Bodyweight
*/

class MuscleGroup {
  
}
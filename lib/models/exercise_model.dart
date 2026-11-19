class ExerciseModel {
  final String id;
  String title;
  int durationMinutes;
  String level;
  String category;
  double progress;
  bool isCompleted;

  ExerciseModel({
    required this.id,
    required this.title,
    required this.durationMinutes,
    required this.level,
    required this.category,
    this.progress = 0.0,
    this.isCompleted = false,
  });
}

// Daftar latihan bagianmu (tanpa Push Up)
final List<ExerciseModel> initialExerciseList = [
  ExerciseModel(
    id: 'ex1',
    title: 'Pull Up',
    durationMinutes: 10,
    level: 'Ahli',
    category: 'Kekuatan',
    progress: 0.25,
    isCompleted: false,
  ),
  ExerciseModel(
    id: 'ex2',
    title: 'Sit Up',
    durationMinutes: 12,
    level: 'Pemula',
    category: 'Inti',
    progress: 0.65,
    isCompleted: true,
  ),
  ExerciseModel(
    id: 'ex3',
    title: 'Squat Dumble',
    durationMinutes: 20,
    level: 'Menengah',
    category: 'Kekuatan',
    progress: 0.45,
    isCompleted: false,
  ),
  ExerciseModel(
    id: 'ex4',
    title: 'Plank Siku',
    durationMinutes: 5,
    level: 'Pemula',
    category: 'Inti',
    progress: 1.0,
    isCompleted: true,
  ),
  ExerciseModel(
    id: 'ex5',
    title: 'Jumping Jack',
    durationMinutes: 15,
    level: 'Menengah',
    category: 'Kardio',
    progress: 1.0,
    isCompleted: true,
  ),
];
class ExerciseModel {
  String nama;
  String durasi;
  String level;
  String kategori;
  double progress;
  List<String> ototDilatih;

  ExerciseModel({
    required this.nama,
    required this.durasi,
    required this.level,
    required this.kategori,
    required this.progress,
    required this.ototDilatih,
  });
}

List<ExerciseModel> daftarLatihan = [
  ExerciseModel(
    nama: 'Push Up',
    durasi: '15 Menit',
    level: 'Menengah',
    kategori: 'STRENGTH',
    progress: 1.0,
    ototDilatih: ['Dada', 'Bahu', 'Trisep'],
  ),
  ExerciseModel(
    nama: 'Pull Up',
    durasi: '10 Menit',
    level: 'Menengah',
    kategori: 'KEKUATAN',
    progress: 0.45,
    ototDilatih: ['Punggung', 'Bisep', 'Bahu'],
  ),
  ExerciseModel(
    nama: 'Sit Up',
    durasi: '12 Menit',
    level: 'Pemula',
    kategori: 'INTI',
    progress: 1.0,
    ototDilatih: ['Perut Atas', 'Perut Bawah', 'Pinggul'],
  ),
  ExerciseModel(
    nama: 'Squat Jump',
    durasi: '15 Menit',
    level: 'Menengah',
    kategori: 'KEKUATAN',
    progress: 0.2,
    ototDilatih: ['Paha Depan', 'Betis', 'Glutes'],
  ),
  ExerciseModel(
    nama: 'Plank Hold',
    durasi: '5 Menit',
    level: 'Pemula',
    kategori: 'INTI',
    progress: 1.0,
    ototDilatih: ['Core', 'Punggung Bawah', 'Bahu'],
  ),
  ExerciseModel(
    nama: 'Jumping Jack',
    durasi: '10 Menit',
    level: 'Pemula',
    kategori: 'KARDIO',
    progress: 1.0,
    ototDilatih: ['Betis', 'Bahu', 'Jantung'],
  ),
];
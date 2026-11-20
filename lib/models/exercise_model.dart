class ExerciseModel {
  String nama;
  String durasi;
  String level;
  String kategori;
  double progress;
  List<String> ototDilatih; // List bersarang di dalam objek

  ExerciseModel({
    required this.nama,
    required this.durasi,
    required this.level,
    required this.kategori,
    required this.progress,
    required this.ototDilatih,
  });
}

// 1. STRUKTUR DATA LINEAR (List objek model)
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
    kategori: 'STRENGTH',
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
    kategori: 'STRENGTH',
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

// 2. STRUKTUR DATA NON-LINEAR (Map mengelompokkan latihan per kategori)
Map<String, List<ExerciseModel>> kelompokkanPerKategori(
    List<ExerciseModel> list,
    ) {
  Map<String, List<ExerciseModel>> hasil = {};
  for (var item in list) {
    if (!hasil.containsKey(item.kategori)) {
      hasil[item.kategori] = [];
    }
    hasil[item.kategori]!.add(item);
  }
  return hasil;
}
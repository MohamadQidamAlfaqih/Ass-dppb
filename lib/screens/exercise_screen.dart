import 'package:flutter/material.dart';
import '../models/exercise_model.dart';
import '../widgets/exercise_card.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({super.key});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  final List<ExerciseModel> _exercises = List.from(daftarLatihan);
  String _kategoriDipilih = 'SEMUA';

  double get _persenHarian {
    if (_exercises.isEmpty) return 0.0;
    int selesai = _exercises.where((e) => e.progress >= 1.0).length;
    return selesai / _exercises.length;
  }

  // Membuka BottomSheet untuk menambah latihan baru
  void _bukaFormTambah() {
    final TextEditingController namaCtrl = TextEditingController();
    final TextEditingController durasiCtrl = TextEditingController();
    String level = 'Pemula';
    String kategori = 'STRENGTH';
    String? errorMsg;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetCtx) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tambah Latihan Baru',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: namaCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Nama Gerakan',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: durasiCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Durasi (Menit)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: level,
                          decoration: const InputDecoration(
                            labelText: 'Level',
                            border: OutlineInputBorder(),
                          ),
                          items: ['Pemula', 'Menengah', 'Ahli']
                              .map((e) =>
                              DropdownMenuItem(value: e, child: Text(e)))
                              .toList(),
                          onChanged: (val) {
                            if (val != null) setSheetState(() => level = val);
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: kategori,
                          decoration: const InputDecoration(
                            labelText: 'Kategori',
                            border: OutlineInputBorder(),
                          ),
                          items: ['STRENGTH', 'INTI', 'KARDIO']
                              .map((e) =>
                              DropdownMenuItem(value: e, child: Text(e)))
                              .toList(),
                          onChanged: (val) {
                            if (val != null) {
                              setSheetState(() => kategori = val);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  if (errorMsg != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      errorMsg!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ],
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF16A34A),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        String nama = namaCtrl.text.trim();
                        int? menit = int.tryParse(durasiCtrl.text.trim());

                        if (nama.isEmpty || menit == null || menit <= 0) {
                          setSheetState(() {
                            errorMsg =
                            'Nama gerakan dan durasi (angka > 0) wajib diisi!';
                          });
                          return;
                        }

                        setState(() {
                          _exercises.add(
                            ExerciseModel(
                              nama: nama,
                              durasi: '$menit Menit',
                              level: level,
                              kategori: kategori,
                              progress: 0.0,
                              ototDilatih: ['Full Body', 'Core'],
                            ),
                          );
                        });

                        Navigator.pop(sheetCtx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Latihan "$nama" berhasil ditambah.'),
                          ),
                        );
                      },
                      child: const Text('SIMPAN LATIHAN'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // AlertDialog konfirmasi hapus + SnackBar dengan aksi BATAL
  void _hapusLatihan(ExerciseModel item) {
    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: const Text('Hapus Latihan'),
        content: Text('Yakin ingin menghapus "${item.nama}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogCtx),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              int indexLama = _exercises.indexOf(item);
              Navigator.pop(dialogCtx);

              setState(() {
                _exercises.remove(item);
              });

              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('"${item.nama}" dihapus.'),
                  action: SnackBarAction(
                    label: 'BATAL',
                    textColor: const Color(0xFF86EFAC),
                    onPressed: () {
                      setState(() {
                        _exercises.insert(indexLama, item);
                      });
                    },
                  ),
                ),
              );
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  // Navigasi ke halaman detail & menerima data balik via Navigator.pop(context, data)
  Future<void> _bukaDetailLatihan(ExerciseModel item) async {
    final hasil = await Navigator.pushNamed(
      context,
      '/push_up',
      arguments: item,
    );

    if (hasil == true && mounted) {
      setState(() {
        item.progress = 1.0;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Selamat! ${item.nama} telah selesai 100%.'),
          backgroundColor: const Color(0xFF16A34A),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Penggunaan struktur data non-linear Map<String, List<ExerciseModel>>
    Map<String, List<ExerciseModel>> dataPerKategori =
    kelompokkanPerKategori(_exercises);

    List<ExerciseModel> dataTampil = _kategoriDipilih == 'SEMUA'
        ? _exercises
        : (dataPerKategori[_kategoriDipilih] ?? []);

    int jumlahSelesai = _exercises.where((e) => e.progress >= 1.0).length;
    int persentase = (_persenHarian * 100).round();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: Color(0xFF166534),
              child: Icon(Icons.person, color: Colors.white, size: 18),
            ),
            SizedBox(width: 10),
            Text(
              'HIDUP SEHAT',
              style: TextStyle(
                color: Color(0xFF166534),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black87),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Belum ada notifikasi baru')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kartu Progress Harian
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator(
                          value: _persenHarian,
                          strokeWidth: 10,
                          backgroundColor: const Color(0xFFE5E7EB),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xFF22C55E),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            '$persentase%',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'TARGET',
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Progress Harian',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$jumlahSelesai dari ${_exercises.length} aktivitas selesai hari ini',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Header Latihan Populer + Tombol Tambah (membuka BottomSheet)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Latihan Populer',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: _bukaFormTambah,
                  child: const Text(
                    '+ Tambah',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF16A34A),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            // Filter Kategori dari Map<String, List<ExerciseModel>>
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ['SEMUA', ...dataPerKategori.keys].map((kat) {
                  bool aktif = _kategoriDipilih == kat;
                  int jumlah = kat == 'SEMUA'
                      ? _exercises.length
                      : dataPerKategori[kat]!.length;

                  return Padding(
                    padding: const EdgeInsets.only(right: 8, bottom: 12),
                    child: ChoiceChip(
                      label: Text('$kat ($jumlah)'),
                      selected: aktif,
                      selectedColor: const Color(0xFFB7F0C0),
                      onSelected: (_) {
                        setState(() {
                          _kategoriDipilih = kat;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),

            // ADAPTIVE LAYOUT: < 600 px ListView 1 kolom, >= 600 px GridView 2 kolom
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth < 600) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: dataTampil.length,
                    itemBuilder: (context, index) {
                      final item = dataTampil[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: ExerciseCard(
                          item: item,
                          onTap: () => _bukaDetailLatihan(item),
                          onDelete: () => _hapusLatihan(item),
                        ),
                      );
                    },
                  );
                } else {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: dataTampil.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.4,
                    ),
                    itemBuilder: (context, index) {
                      final item = dataTampil[index];
                      return ExerciseCard(
                        item: item,
                        onTap: () => _bukaDetailLatihan(item),
                        onDelete: () => _hapusLatihan(item),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buatBottomNav(),
    );
  }

  Widget _buatBottomNav() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8F5),
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _itemNav(Icons.grid_view_rounded, 'Dashboard', false, () {
            Navigator.pushReplacementNamed(context, '/dashboard');
          }),
          _itemNav(Icons.fitness_center, 'Exercise', true, () {}),
          _itemNav(Icons.cloud_outlined, 'Weather', false, () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Menu Weather')),
            );
          }),
          _itemNav(Icons.calendar_today_outlined, 'Schedule', false, () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Menu Schedule')),
            );
          }),
        ],
      ),
    );
  }

  Widget _itemNav(
      IconData ikon,
      String label,
      bool aktif,
      VoidCallback onTap,
      ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: aktif ? const Color(0xFFB7F0C0) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              ikon,
              size: 20,
              color: aktif ? const Color(0xFF15803D) : Colors.grey.shade600,
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: aktif ? FontWeight.bold : FontWeight.normal,
                color: aktif ? const Color(0xFF15803D) : Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
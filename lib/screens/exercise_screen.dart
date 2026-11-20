import 'package:flutter/material.dart';
import '../models/exercise_model.dart';
import '../widgets/exercise_card.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({super.key});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  final List<ExerciseModel> _exercises = daftarLatihan;

  Future<void> _bukaHalamanDetail(ExerciseModel item) async {
    final hasil = await Navigator.pushNamed(
      context,
      '/push_up',
      arguments: item,
    );

    if (hasil == true && mounted) {
      setState(() {
        item.progress = 1.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int jumlahSelesai = _exercises.where((e) => e.progress >= 1.0).length;
    double nilaiProgress =
    _exercises.isEmpty ? 0.0 : jumlahSelesai / _exercises.length;
    int persen = (nilaiProgress * 100).round();

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
                          value: nilaiProgress,
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
                            '$persen%',
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

            // Header Latihan Populer
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Latihan Populer',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Lihat Semua',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF16A34A),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Grid Kartu Latihan (2 kolom di HP, 3 kolom di layar lebar)
            LayoutBuilder(
              builder: (context, constraints) {
                int jumlahKolom = constraints.maxWidth < 600 ? 2 : 3;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _exercises.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: jumlahKolom,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.95,
                  ),
                  itemBuilder: (context, index) {
                    final item = _exercises[index];
                    return ExerciseCard(
                      item: item,
                      onTap: () => _bukaHalamanDetail(item),
                    );
                  },
                );
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
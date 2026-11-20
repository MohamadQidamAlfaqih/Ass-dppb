import 'package:flutter/material.dart';
import '../models/exercise_model.dart';

class PushUpScreen extends StatelessWidget {
  const PushUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ExerciseModel? args =
    ModalRoute.of(context)?.settings.arguments as ExerciseModel?;

    final String namaGerakan = args?.nama ?? 'Push Up';
    final String kategori = args?.kategori ?? 'STRENGTH';
    final String levelKesulitan = args?.level ?? 'Menengah';
    final List<String> daftarOtot =
        args?.ototDilatih ?? ['Dada', 'Bahu', 'Trisep'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1B5E20)),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushReplacementNamed(context, '/exercise');
            }
          },
        ),
        title: const Text(
          'HIDUP SEHAT',
          style: TextStyle(
            color: Color(0xFF1E293B),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Color(0xFF1B5E20)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Belum ada notifikasi baru')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              namaGerakan,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _buatBadge(kategori, const Color(0xFF00B862)),
                const SizedBox(width: 8),
                _buatBadge('BODYWEIGHT', const Color(0xFFFF6D00)),
              ],
            ),
            const SizedBox(height: 16),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.fitness_center,
                      size: 64,
                      color: Colors.white24,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Memutar panduan video $namaGerakan...'),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: const BoxDecoration(
                      color: Colors.white30,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'OTOT YANG DILATIH',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: List.generate(daftarOtot.length, (i) {
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: i < daftarOtot.length - 1 ? 10 : 0,
                    ),
                    child: _buatKartuOtot(
                      daftarOtot[i],
                      i == 0 ? 'Primary' : 'Secondary',
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),
            const Text(
              'INSTRUKSI LANGKAH-DEMI-LANGKAH',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            _buatKartuLangkah(
              nomor: '01',
              judul: 'Posisi Awal',
              deskripsi:
              'Mulailah dengan posisi plank, tangan diletakkan sedikit lebih lebar dari lebar bahu.',
              warnaLatar: const Color(0xFFFBE9E0),
            ),
            const SizedBox(height: 10),
            _buatKartuLangkah(
              nomor: '02',
              judul: 'Turunkan Tubuh',
              deskripsi:
              'Turunkan tubuh Anda sampai dada hampir menyentuh lantai sambil menjaga punggung tetap lurus.',
              warnaLatar: const Color(0xFFFCE4EC),
            ),
            const SizedBox(height: 10),
            _buatKartuLangkah(
              nomor: '03',
              judul: 'Dorong Ke Atas',
              deskripsi:
              'Hembuskan napas saat Anda mendorong tubuh kembali ke posisi awal dengan tangan Anda.',
              warnaLatar: const Color(0xFFE3F2FD),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: _buatKartuInfo('KESULITAN', levelKesulitan)),
                const SizedBox(width: 12),
                Expanded(child: _buatKartuInfo('PERALATAN', 'Tanpa Alat')),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Mengirim data 'true' kembali ke ExerciseScreen
                  Navigator.pop(context, true);
                },
                icon: const Icon(Icons.bolt, size: 20),
                label: const Text(
                  'SELESAIKAN LATIHAN',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0B6E4F),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buatBottomNav(context),
    );
  }

  Widget _buatBadge(String teks, Color warna) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: warna,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        teks,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buatKartuOtot(String namaOtot, String peran) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFDCFCE7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            namaOtot,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Color(0xFF166534),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            peran,
            style: const TextStyle(fontSize: 11, color: Color(0xFF15803D)),
          ),
        ],
      ),
    );
  }

  Widget _buatKartuLangkah({
    required String nomor,
    required String judul,
    required String deskripsi,
    required Color warnaLatar,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: warnaLatar,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            nomor,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF475569),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  judul,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  deskripsi,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF334155),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buatKartuInfo(String label, String nilai) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFDCFCE7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Color(0xFF15803D),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            nilai,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buatBottomNav(BuildContext context) {
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
          _itemNav(Icons.fitness_center, 'Exercise', true, () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushReplacementNamed(context, '/exercise');
            }
          }),
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
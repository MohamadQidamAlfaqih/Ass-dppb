import 'package:flutter/material.dart';
import '../models/exercise.dart';

class DetailExerciseScreen extends StatelessWidget {
  const DetailExerciseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Menerima data dari halaman Exercise (kalau null, otomatis pakai data Push Up)
    final Exercise? args =
    ModalRoute.of(context)?.settings.arguments as Exercise?;

    final String namaGerakan = args?.nama ?? 'Push Up';
    final String kategori = args?.kategori ?? 'STRENGTH';

    return Scaffold(
      backgroundColor: Colors.white,
      // AppBar sesuai desain: tombol back, judul HIDUP SEHAT di tengah, ikon lonceng
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1B5E20)),
          onPressed: () => Navigator.pop(context),
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

      // SingleChildScrollView mencegah error overflow saat layar diputar landscape
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Judul Gerakan (Push Up)
            Text(
              namaGerakan,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 8),

            // 2. Dua Badge Kategori (Hijau & Oranye)
            Row(
              children: [
                _buatBadge(kategori.toUpperCase(), const Color(0xFF00B862)),
                const SizedBox(width: 8),
                _buatBadge('BODYWEIGHT', const Color(0xFFFF6D00)),
              ],
            ),
            const SizedBox(height: 16),

            // 3. Banner Preview Gerakan menggunakan Stack (Kotak Gambar + Tombol Play)
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
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.fitness_center,
                        size: 64,
                        color: Colors.white24,
                      ),
                    ],
                  ),
                ),
                // Tombol Play bulat transparan di tengah Stack
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
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
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

            // 4. Bagian "OTOT YANG DILATIH" (3 Kotak Hijau Muda sejajar pakai Row & Expanded)
            const Text(
              'OTOT YANG DILATIH',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: _buatKartuOtot('Dada', 'Primary')),
                const SizedBox(width: 10),
                Expanded(child: _buatKartuOtot('Bahu', 'Secondary')),
                const SizedBox(width: 10),
                Expanded(child: _buatKartuOtot('Trisep', 'Secondary')),
              ],
            ),
            const SizedBox(height: 24),

            // 5. Bagian "INSTRUKSI LANGKAH-DEMI-LANGKAH" (3 Kartu Warna Pastel)
            const Text(
              'INSTRUKSI LANGKAH-DEMI-LANGKAH',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 10),
            _buatKartuLangkah(
              nomor: '01',
              judul: 'Posisi Awal',
              deskripsi:
              'Mulailah dengan posisi plank, tangan diletakkan sedikit lebih lebar dari lebar bahu.',
              warnaLatar: const Color(0xFFFBE9E0), // Krem / Peach lembut
            ),
            const SizedBox(height: 10),
            _buatKartuLangkah(
              nomor: '02',
              judul: 'Turunkan Tubuh',
              deskripsi:
              'Turunkan tubuh Anda sampai dada hampir menyentuh lantai sambil menjaga punggung tetap lurus.',
              warnaLatar: const Color(0xFFFCE4EC), // Pink lembut
            ),
            const SizedBox(height: 10),
            _buatKartuLangkah(
              nomor: '03',
              judul: 'Dorong Ke Atas',
              deskripsi:
              'Hembuskan napas saat Anda mendorong tubuh kembali ke posisi awal dengan tangan Anda.',
              warnaLatar: const Color(0xFFE3F2FD), // Biru lembut
            ),
            const SizedBox(height: 20),

            // 6. Bagian Kesulitan & Peralatan (2 Kotak Hijau Muda sejajar)
            Row(
              children: [
                Expanded(child: _buatKartuInfo('KESULITAN', 'Menengah')),
                const SizedBox(width: 12),
                Expanded(child: _buatKartuInfo('PERALATAN', 'Tanpa Alat')),
              ],
            ),
            const SizedBox(height: 24),

            // 7. Tombol Utama "MULAI LATIHAN"
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Latihan $namaGerakan dimulai! Semangat!'),
                      backgroundColor: const Color(0xFF0B6E4F),
                    ),
                  );
                },
                icon: const Icon(Icons.bolt, size: 20),
                label: const Text(
                  'MULAI LATIHAN',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
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
    );
  }

  // Fungsi pembantu sederhana di dalam file yang sama agar kode tidak berulang
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
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF15803D),
            ),
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
}
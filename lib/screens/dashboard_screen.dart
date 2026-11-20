import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _isWeekly = true;

  @override
  Widget build(BuildContext context) {
    final String namaUser =
        (ModalRoute.of(context)?.settings.arguments as String?) ?? 'User';

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF166534)),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/login');
          },
        ),
        title: const Text(
          'HIDUP SEHAT',
          style: TextStyle(
            color: Color(0xFF166534),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Color(0xFF166534),
              child: Icon(Icons.person, color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Halo, $namaUser!',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF16A34A),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Your Daily\nWellness Journey\nStarts Here!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
                height: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Track your progress and hit your goals with personalized insights daily.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/exercise');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF16A34A),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Start New Activity',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search workouts, plans, articles...',
                hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
                prefixIcon: const Icon(Icons.search, size: 18),
                filled: true,
                fillColor: const Color(0xFFE2E8F0),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Daily Progress',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/exercise');
                  },
                  child: const Text(
                    'View Details',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF16A34A),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buatKartuProgress(
              judul: 'STEPS',
              angka: '8,452',
              keterangan: '+12% vs yesterday',
              warnaLatar: const Color(0xFFFFEDD5),
              warnaTeks: const Color(0xFFEA580C),
              ikon: Icons.directions_walk,
            ),
            const SizedBox(height: 10),
            _buatKartuProgress(
              judul: 'CALORIES',
              angka: '2,340',
              keterangan: 'Goal: 2,500 kcal',
              warnaLatar: const Color(0xFFFEE2E2),
              warnaTeks: const Color(0xFFDC2626),
              ikon: Icons.local_fire_department,
            ),
            const SizedBox(height: 10),
            _buatKartuProgress(
              judul: 'MINUTES',
              angka: '48 min',
              keterangan: 'Daily Goal Reached!',
              warnaLatar: const Color(0xFFDBEAFE),
              warnaTeks: const Color(0xFF2563EB),
              ikon: Icons.timer,
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Activity\nTrend',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => setState(() => _isWeekly = true),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: _isWeekly
                                    ? const Color(0xFF16A34A)
                                    : Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'Weekly',
                                style: TextStyle(
                                  fontSize: 11,
                                  color:
                                  _isWeekly ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          GestureDetector(
                            onTap: () => setState(() => _isWeekly = false),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: !_isWeekly
                                    ? const Color(0xFF16A34A)
                                    : Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'Monthly',
                                style: TextStyle(
                                  fontSize: 11,
                                  color:
                                  !_isWeekly ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buatBatangGrafik('MON', _isWeekly ? 40 : 60),
                      _buatBatangGrafik('TUE', _isWeekly ? 60 : 75),
                      _buatBatangGrafik('WED', _isWeekly ? 80 : 65),
                      _buatBatangGrafik('THU', _isWeekly ? 50 : 85),
                      _buatBatangGrafik('FRI', _isWeekly ? 65 : 55),
                      _buatBatangGrafik('SAT', _isWeekly ? 30 : 70),
                      _buatBatangGrafik('SUN', _isWeekly ? 45 : 60),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Recent Logs',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buatItemLog(
              ikon: Icons.directions_run,
              warnaIkon: const Color(0xFF16A34A),
              warnaLatar: const Color(0xFFDCFCE7),
              judul: 'Evening Run',
              subjudul: '4.2 km • 32 mins',
              kananAtas: '+320',
              kananBawah: 'kcal',
            ),
            const SizedBox(height: 8),
            _buatItemLog(
              ikon: Icons.bedtime,
              warnaIkon: const Color(0xFF7C3AED),
              warnaLatar: const Color(0xFFEDE9FE),
              judul: 'Deep Sleep',
              subjudul: '7h 20m • Good',
              kananAtas: '88%',
              kananBawah: 'score',
            ),
            const SizedBox(height: 8),
            _buatItemLog(
              ikon: Icons.water_drop,
              warnaIkon: const Color(0xFF0284C7),
              warnaLatar: const Color(0xFFE0F2FE),
              judul: 'Hydration Target',
              subjudul: '1.8L / 2.5L daily',
              kananAtas: '72%',
              kananBawah: 'goal',
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buatBottomNav(),
    );
  }

  Widget _buatKartuProgress({
    required String judul,
    required String angka,
    required String keterangan,
    required Color warnaLatar,
    required Color warnaTeks,
    required IconData ikon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: warnaLatar,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                judul,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: warnaTeks,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                angka,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: warnaTeks,
                ),
              ),
              Text(
                keterangan,
                style: TextStyle(fontSize: 11, color: warnaTeks),
              ),
            ],
          ),
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(ikon, color: warnaTeks),
          ),
        ],
      ),
    );
  }

  Widget _buatBatangGrafik(String hari, double tinggi) {
    return Column(
      children: [
        Container(
          width: 24,
          height: tinggi,
          decoration: BoxDecoration(
            color: const Color(0xFF22C55E),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(height: 6),
        Text(hari, style: const TextStyle(fontSize: 9, color: Colors.grey)),
      ],
    );
  }

  Widget _buatItemLog({
    required IconData ikon,
    required Color warnaIkon,
    required Color warnaLatar,
    required String judul,
    required String subjudul,
    required String kananAtas,
    required String kananBawah,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: warnaLatar,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(ikon, color: warnaIkon, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  judul,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                Text(
                  subjudul,
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                kananAtas,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: warnaIkon,
                ),
              ),
              Text(
                kananBawah,
                style: const TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
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
          _itemNav(Icons.grid_view_rounded, 'Dashboard', true, () {}),
          _itemNav(Icons.fitness_center, 'Exercise', false, () {
            Navigator.pushReplacementNamed(context, '/exercise');
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
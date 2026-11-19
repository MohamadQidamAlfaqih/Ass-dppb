import 'package:flutter/material.dart';
import '../models/exercise_model.dart';
import '../widgets/exercise_card.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({super.key});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  static const double _mobileMaxWidth = 430;

  final List<ExerciseModel> _exercises = List<ExerciseModel>.from(
    initialExerciseList,
  );
  int _navIndex = 1; // 0: Dashboard, 1: Exercise, 2: Weather, 3: Schedule

  double get _dailyProgress {
    if (_exercises.isEmpty) return 0.0;
    final int doneCount = _exercises.where((e) => e.isCompleted).length;
    return doneCount / _exercises.length;
  }

  void _showSnack(String message, {SnackBarAction? action}) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        action: action,
      ),
    );
  }

  void _openExerciseForm({ExerciseModel? existing}) {
    final bool isEditing = existing != null;
    final TextEditingController titleCtrl = TextEditingController(
      text: existing?.title ?? '',
    );
    final TextEditingController durationCtrl = TextEditingController(
      text: existing != null ? existing.durationMinutes.toString() : '',
    );
    String selectedLevel = existing?.level ?? 'Pemula';
    String selectedCategory = existing?.category ?? 'Kekuatan';
    bool isCompleted = existing?.isCompleted ?? false;
    String? errorText;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isEditing ? 'Edit Latihan' : 'Tambah Latihan',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      controller: titleCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Nama Latihan',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: durationCtrl,
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
                            value: selectedLevel,
                            decoration: const InputDecoration(
                              labelText: 'Level',
                              border: OutlineInputBorder(),
                            ),
                            items: const ['Pemula', 'Menengah', 'Ahli']
                                .map((lvl) => DropdownMenuItem<String>(
                                      value: lvl,
                                      child: Text(lvl),
                                    ))
                                .toList(),
                            onChanged: (val) {
                              if (val != null) {
                                setSheetState(() => selectedLevel = val);
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectedCategory,
                            decoration: const InputDecoration(
                              labelText: 'Kategori',
                              border: OutlineInputBorder(),
                            ),
                            items: const ['Kekuatan', 'Kardio', 'Inti']
                                .map((cat) => DropdownMenuItem<String>(
                                      value: cat,
                                      child: Text(cat),
                                    ))
                                .toList(),
                            onChanged: (val) {
                              if (val != null) {
                                setSheetState(() => selectedCategory = val);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Sudah selesai hari ini'),
                      value: isCompleted,
                      activeTrackColor: const Color(0xFF16A34A),
                      onChanged: (val) {
                        setSheetState(() => isCompleted = val);
                      },
                    ),
                    if (errorText != null) ...[
                      Text(
                        errorText!,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      ),
                      const SizedBox(height: 8),
                    ],
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF16A34A),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () {
                          final String title = titleCtrl.text.trim();
                          final int? duration =
                              int.tryParse(durationCtrl.text.trim());

                          if (title.isEmpty ||
                              duration == null ||
                              duration <= 0) {
                            setSheetState(() {
                              errorText =
                                  'Isi nama latihan dan durasi (angka > 0).';
                            });
                            return;
                          }

                          setState(() {
                            if (isEditing) {
                              existing.title = title;
                              existing.durationMinutes = duration;
                              existing.level = selectedLevel;
                              existing.category = selectedCategory;
                              existing.isCompleted = isCompleted;
                              existing.progress = isCompleted ? 1.0 : 0.45;
                            } else {
                              _exercises.add(
                                ExerciseModel(
                                  id: DateTime.now()
                                      .millisecondsSinceEpoch
                                      .toString(),
                                  title: title,
                                  durationMinutes: duration,
                                  level: selectedLevel,
                                  category: selectedCategory,
                                  progress: isCompleted ? 1.0 : 0.0,
                                  isCompleted: isCompleted,
                                ),
                              );
                            }
                          });

                          Navigator.pop(sheetContext);
                          _showSnack(
                            isEditing
                                ? '"$title" diperbarui.'
                                : '"$title" ditambahkan.',
                          );
                        },
                        child: Text(isEditing ? 'Simpan Perubahan' : 'Simpan'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    ).whenComplete(() {
      titleCtrl.dispose();
      durationCtrl.dispose();
    });
  }

  void _deleteExercise(ExerciseModel item) {
    final int index = _exercises.indexOf(item);
    if (index == -1) return;

    setState(() {
      _exercises.removeAt(index);
    });

    _showSnack(
      '"${item.title}" dihapus.',
      action: SnackBarAction(
        label: 'BATAL',
        textColor: const Color(0xFF86EFAC),
        onPressed: () {
          setState(() {
            _exercises.insert(index, item);
          });
        },
      ),
    );
  }

  void _toggleCompleted(ExerciseModel item) {
    setState(() {
      item.isCompleted = !item.isCompleted;
      item.progress = item.isCompleted ? 1.0 : 0.45;
    });
  }

  Widget _buildProgressCard() {
    final int completedCount =
        _exercises.where((item) => item.isCompleted).length;
    final int percent = (_dailyProgress * 100).round();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 104,
                height: 104,
                child: CircularProgressIndicator(
                  value: _dailyProgress.clamp(0.0, 1.0),
                  strokeWidth: 10,
                  backgroundColor: const Color(0xFFE5E7EB),
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(Color(0xFF22C55E)),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$percent%',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const Text(
                    'TARGET',
                    style: TextStyle(
                      fontSize: 10,
                      letterSpacing: 0.5,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            'Progress Harian',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$completedCount dari ${_exercises.length} aktivitas selesai hari ini',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    const items = [
      (icon: Icons.grid_view_rounded, label: 'Dashboard'),
      (icon: Icons.open_in_full_rounded, label: 'Exercise'),
      (icon: Icons.cloud_outlined, label: 'Weather'),
      (icon: Icons.calendar_today_outlined, label: 'Schedule'),
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF7F8F5),
        border: Border(
          top: BorderSide(color: Color(0xFFDDE5DD), width: 1),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final bool active = _navIndex == index;
          final item = items[index];

          return InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              setState(() => _navIndex = index);
              if (index != 1) {
                _showSnack('Tab ${item.label} dikelola bagian tim lain.');
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: active ? const Color(0xFFB7F0C0) : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    item.icon,
                    size: 20,
                    color: active
                        ? const Color(0xFF15803D)
                        : const Color(0xFF4B5563),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.label,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: active ? FontWeight.w600 : FontWeight.normal,
                      color: active
                          ? const Color(0xFF15803D)
                          : const Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5E7EB),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: _mobileMaxWidth),
          child: Scaffold(
            backgroundColor: const Color(0xFFF8FAFC),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              titleSpacing: 16,
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
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.notifications_none,
                    color: Colors.black87,
                  ),
                  onPressed: () =>
                      _showSnack('Belum ada notifikasi baru hari ini.'),
                ),
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProgressCard(),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Latihan Populer',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      TextButton(
                        onPressed: () => _openExerciseForm(),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          '+ Tambah',
                          style: TextStyle(
                            color: Color(0xFF16A34A),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _exercises.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.92,
                    ),
                    itemBuilder: (context, index) {
                      final item = _exercises[index];
                      return ExerciseCard(
                        exercise: item,
                        onTap: () => _toggleCompleted(item),
                        onEdit: () => _openExerciseForm(existing: item),
                        onDelete: () => _deleteExercise(item),
                      );
                    },
                  ),
                ],
              ),
            ),
            bottomNavigationBar: _buildBottomNav(),
          ),
        ),
      ),
    );
  }
}
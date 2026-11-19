import 'package:flutter/material.dart';
import '../models/exercise_model.dart';

class ExerciseCard extends StatelessWidget {
  final ExerciseModel exercise;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ExerciseCard({
    super.key,
    required this.exercise,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  IconData _resolveIcon(String title) {
    final lower = title.toLowerCase();
    if (lower.contains('pull')) return Icons.fitness_center;
    if (lower.contains('sit')) return Icons.accessibility_new;
    if (lower.contains('squat')) return Icons.sports_gymnastics;
    if (lower.contains('plank')) return Icons.timer_outlined;
    if (lower.contains('jump')) return Icons.directions_run;
    return Icons.fitness_center;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F8F5),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: exercise.isCompleted
                ? const Color(0xFF22C55E).withValues(alpha: 0.5)
                : Colors.transparent,
            width: 1.2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFBBF7D0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    _resolveIcon(exercise.title),
                    color: const Color(0xFF166534),
                    size: 20,
                  ),
                ),
                PopupMenuButton<String>(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: Icon(
                    Icons.more_vert,
                    size: 18,
                    color: Colors.grey.shade700,
                  ),
                  onSelected: (value) {
                    if (value == 'edit') {
                      onEdit();
                    } else if (value == 'delete') {
                      onDelete();
                    }
                  },
                  itemBuilder: (context) => const [
                    PopupMenuItem<String>(
                      value: 'edit',
                      child: Text('Edit'),
                    ),
                    PopupMenuItem<String>(
                      value: 'delete',
                      child: Text(
                        'Hapus',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              exercise.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Color(0xFF1E293B),
              ),
            ),
            Text(
              '${exercise.durationMinutes} Menit • ${exercise.level}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: exercise.progress.clamp(0.0, 1.0),
                minHeight: 4,
                backgroundColor: const Color(0xFFE2E8F0),
                valueColor: AlwaysStoppedAnimation<Color>(
                  exercise.isCompleted
                      ? const Color(0xFF22C55E)
                      : const Color(0xFF111827),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
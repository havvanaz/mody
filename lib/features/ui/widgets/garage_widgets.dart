import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class GarageCard extends StatelessWidget {
  final int index;
  const GarageCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GarageGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://picsum.photos/seed/garage$index/600/800',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text('Job #'),
              Text(
                '$index',
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
              const Spacer(),
              PopupMenuButton<String>(
                color: AppColors.surface,
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 'share', child: Text('Share')),
                  const PopupMenuItem(value: 'rename', child: Text('Rename')),
                  const PopupMenuItem(value: 'delete', child: Text('Delete')),
                ],
                onSelected: (v) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('$v (UI only)')));
                },
                child: const Icon(Icons.more_horiz),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class GarageGlassCard extends StatelessWidget {
  final Widget child;
  const GarageGlassCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: child,
    );
  }
}

import 'package:flutter/material.dart';
import '../../main.dart' show AppColors;

class TrendCard extends StatelessWidget {
  final int index;
  const TrendCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return TrendingGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://picsum.photos/seed/trend$index/600/800',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: const [
              Icon(Icons.favorite_border, size: 16),
              SizedBox(width: 6),
              Text('1.2k'),
              Spacer(),
              Icon(Icons.person_2_outlined, size: 16),
              SizedBox(width: 6),
              Text('@user'),
            ],
          ),
        ],
      ),
    );
  }
}

class TrendingGlassCard extends StatelessWidget {
  final Widget child;
  const TrendingGlassCard({super.key, required this.child});

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

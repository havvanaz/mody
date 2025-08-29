import 'package:flutter/material.dart';
import '../../main.dart' show AppColors;
import '../../core/constants/app_images.dart';

class TrendingPage extends StatelessWidget {
  const TrendingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(16, 96, 16, 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: .78,
      ),
      itemCount: 12,
      itemBuilder: (_, i) => _trendCard(i),
    );
  }
}

Widget _trendCard(int i) => _glassCard(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            AppImages.carImages[i % AppImages.carImages.length],
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

Widget _glassCard({required Widget child}) => Container(
  decoration: BoxDecoration(
    color: AppColors.surface,
    border: Border.all(color: AppColors.border),
    borderRadius: BorderRadius.circular(16),
  ),
  padding: const EdgeInsets.all(16),
  child: child,
);

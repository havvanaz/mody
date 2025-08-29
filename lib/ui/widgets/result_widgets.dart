import 'package:flutter/material.dart';
import '../../main.dart' show AppColors;

class ActionIcon extends StatelessWidget {
  final String label;
  final IconData icon;
  const ActionIcon({super.key, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.all(14),
          child: Icon(icon),
        ),
        const SizedBox(height: 6),
        Text(label),
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String text;
  const SectionTitle(this.text, {super.key});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(
        context,
      ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
    );
  }
}

class PresetBubble extends StatelessWidget {
  final int index;
  const PresetBubble({super.key, required this.index});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 76,
          height: 76,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.border),
            image: DecorationImage(
              image: NetworkImage(
                'https://picsum.photos/seed/car$index/200/200',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}

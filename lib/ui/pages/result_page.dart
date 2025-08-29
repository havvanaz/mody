import 'package:flutter/material.dart';
import '../../main.dart' show AppColors;

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  double _dividerX = .5; // 0..1

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Result')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: LayoutBuilder(
                  builder: (context, bc) {
                    final w = bc.maxWidth;
                    final h = bc.maxHeight;
                    final cut = w * _dividerX;
                    return GestureDetector(
                      onHorizontalDragUpdate: (d) {
                        setState(
                          () => _dividerX = (_dividerX + d.delta.dx / w).clamp(
                            0.0,
                            1.0,
                          ),
                        );
                      },
                      child: Stack(
                        children: [
                          // After (full)
                          Positioned.fill(
                            child: Image.network(
                              'https://images.unsplash.com/photo-1549924231-f129b911e442?q=80&w=1600',
                              fit: BoxFit.cover,
                            ),
                          ),
                          // Before (clipped left)
                          Positioned(
                            left: 0,
                            top: 0,
                            bottom: 0,
                            width: cut,
                            child: ClipRect(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                widthFactor: _dividerX,
                                child: Image.network(
                                  'https://images.unsplash.com/photo-1503376780353-7e6692767b70?q=80&w=1600',
                                  fit: BoxFit.cover,
                                  width: w,
                                  height: h,
                                ),
                              ),
                            ),
                          ),
                          // Divider handle
                          Positioned(
                            left: cut - 12,
                            top: 0,
                            bottom: 0,
                            child: Container(
                              width: 24,
                              color: Colors.white.withValues(alpha: 0.15),
                              child: const Center(
                                child: Icon(Icons.drag_indicator),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                _ActionIcon(label: 'Download', icon: Icons.download_outlined),
                _ActionIcon(label: 'Share', icon: Icons.share_outlined),
                _ActionIcon(label: 'Save', icon: Icons.bookmark_outline),
              ],
            ),
            const SizedBox(height: 16),
            const _SectionTitle('Try another preset'),
            const SizedBox(height: 10),
            SizedBox(
              height: 86,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, i) => _PresetBubble(index: i + 10),
                separatorBuilder: (_, __) => const SizedBox(width: 16),
                itemCount: 6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionIcon extends StatelessWidget {
  final String label;
  final IconData icon;
  const _ActionIcon({required this.label, required this.icon});

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

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);
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

class _PresetBubble extends StatelessWidget {
  final int index;
  const _PresetBubble({required this.index});
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

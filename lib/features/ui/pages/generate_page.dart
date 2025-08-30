import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import 'result_page.dart';
import '../widgets/generate_widgets.dart';

class GeneratePage extends StatefulWidget {
  const GeneratePage({super.key});

  @override
  State<GeneratePage> createState() => _GeneratePageState();
}

class _GeneratePageState extends State<GeneratePage> {
  bool customPrompt = false;
  String selectedStyle = 'Style';
  final Set<String> extras = {};
  Color? selectedColor;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 96, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UploadBox(
            customPrompt: customPrompt,
            onTogglePrompt: (v) => setState(() => customPrompt = v),
            onInspire: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Inspire Me (UI only)')),
            ),
          ),
          const SizedBox(height: 16),
          Column(
            children: [
              // Style butonu
              ControlCard(
                child: TileButton(
                  label: selectedStyle,
                  icon: Icons.expand_more,
                  onPressed: () async {
                    final result = await _openStylePicker(context);
                    if (result != null) {
                      setState(() => selectedStyle = result);
                    }
                  },
                ),
              ),
              const SizedBox(height: 12),
              // Extra butonu
              ControlCard(
                child: TileButton(
                  label: 'Extra (+${extras.length})',
                  icon: Icons.add,
                  onPressed: () async {
                    final result = await _openExtraPicker(context, extras);
                    if (result != null) {
                      setState(
                        () => extras
                          ..clear()
                          ..addAll(result),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 12),
              // Color butonu
              ControlCard(
                child: TileButton(
                  label: selectedColor != null
                      ? _hexOf(selectedColor!)
                      : 'Color',
                  icon: Icons.expand_more,
                  onPressed: () async {
                    final color = await _openColorPicker(
                      context,
                      selectedColor,
                    );
                    if (color != null) setState(() => selectedColor = color);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const GenerateSectionTitle('Pre‑made Styles:'),
          const SizedBox(height: 12),
          SizedBox(
            height: 86,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, i) => PresetBubble(index: i),
              separatorBuilder: (context, index) => const SizedBox(width: 16),
              itemCount: 6,
            ),
          ),
          const SizedBox(height: 22),
          GenerateButton(
            onPressed: () async {
              final ok = await _simulateGeneration(context);
              if (!context.mounted) return;
              if (ok) {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ResultPage()),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

Future<String?> _openStylePicker(BuildContext context) async {
  const items = [
    ('JDM', 'low stance, widebody, neon reflections'),
    ('Muscle', 'restomod, matte paint, chrome accents'),
    ('Off‑road', 'lifted, beadlock wheels, roof rack'),
    ('Retro‑mod', '70s vibe, film grain'),
    ('Cyberpunk', 'neon city, holographic decals'),
  ];
  return showModalBottomSheet<String>(
    context: context,
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SheetTitle('Choose Style'),
        for (final (title, desc) in items)
          ListTile(
            title: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            subtitle: Text(desc),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.pop(context, title),
          ),
      ],
    ),
  );
}

Future<Set<String>?> _openExtraPicker(
  BuildContext context,
  Set<String> selected,
) async {
  final opts = ['Spoiler', 'Body kit', 'Wheels', 'Underglow'];
  final temp = {...selected};
  return showModalBottomSheet<Set<String>>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SheetTitle('Extras'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: -8,
            children: [
              for (final o in opts)
                FilterChip(
                  selectedColor: AppColors.primary.withValues(alpha: 0.18),
                  backgroundColor: AppColors.surface,
                  showCheckmark: false,
                  selected: temp.contains(o),
                  label: Text(o),
                  onSelected: (v) =>
                      temp.contains(o) ? temp.remove(o) : temp.add(o),
                ),
            ],
          ),
          const SizedBox(height: 18),
          Align(
            alignment: Alignment.centerRight,
            child: PrimaryButton(
              label: 'Done',
              onPressed: () => Navigator.pop(context, temp),
            ),
          ),
        ],
      ),
    ),
  );
}

Future<Color?> _openColorPicker(BuildContext context, Color? selected) async {
  const palette = [
    Color(0xFFFF1744), // red
    Color(0xFF00E5FF), // cyan
    Color(0xFF7C4DFF), // purple
    Color(0xFFFFC107), // amber
    Color(0xFF00E676), // green
    Color(0xFF90CAF9), // blue
    Color(0xFFFF7043), // deep orange
    Color(0xFFB0BEC5), // silver
  ];
  return showModalBottomSheet<Color>(
    context: context,
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SheetTitle('Choose Color'),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            children: [
              for (final c in palette)
                ColorItem(
                  color: c,
                  selected: selected == c,
                  onTap: () => Navigator.pop(context, c),
                ),
            ],
          ),
        ],
      ),
    ),
  );
}

Future<bool> _simulateGeneration(BuildContext context) async {
  double progress = 0;
  final controller = StreamController<double>();
  Timer? t;
  final ok = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      t = Timer.periodic(const Duration(milliseconds: 80), (timer) {
        progress += .03;
        if (progress >= 1) {
          controller.add(1);
          Navigator.pop(context, true);
          timer.cancel();
        } else {
          controller.add(progress);
        }
      });

      return PopScope(
        canPop: false,
        child: AlertDialog(
          backgroundColor: AppColors.surface,
          content: StreamBuilder<double>(
            stream: controller.stream,
            initialData: 0,
            builder: (c, snap) {
              final p = (snap.data ?? 0);
              return SizedBox(
                width: 260,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Generating...',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 16),
                    LinearProgressIndicator(
                      value: p,
                      color: AppColors.primary,
                      backgroundColor: Colors.white12,
                    ),
                    const SizedBox(height: 8),
                    Text('${(p * 100).toStringAsFixed(0)}%'),
                  ],
                ),
              );
            },
          ),
        ),
      );
    },
  );
  t?.cancel();
  await controller.close();
  return ok == true;
}

String _hexOf(Color c) =>
    '#${c.toARGB32().toRadixString(16).substring(2).toUpperCase()}';

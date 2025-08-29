import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../main.dart' show AppColors;
import '../../core/constants/app_images.dart';

class UploadBox extends StatefulWidget {
  final bool customPrompt;
  final ValueChanged<bool> onTogglePrompt;
  final VoidCallback onInspire;
  const UploadBox({
    super.key,
    required this.customPrompt,
    required this.onTogglePrompt,
    required this.onInspire,
  });

  @override
  State<UploadBox> createState() => _UploadBoxState();
}

class _UploadBoxState extends State<UploadBox> {
  File? _selectedImage;
  bool _isUploading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0x22121214), Color(0x44121214)],
        ),
        border: Border.all(color: AppColors.border, width: 2),
        boxShadow: const [
          BoxShadow(color: Color(0x33000000), blurRadius: 20, spreadRadius: 2),
        ],
      ),
      child: Stack(
        children: [
          Center(
            child: _selectedImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.file(
                      _selectedImage!,
                      width: 160,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.image_outlined,
                        size: 56,
                        color: Colors.white70,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Araç Resmini Ekle',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: Colors.white.withValues(alpha: 0.9),
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  ),
          ),
          Positioned(
            left: 12,
            bottom: 12,
            child: Row(
              children: [
                Switch(
                  value: widget.customPrompt,
                  onChanged: widget.onTogglePrompt,
                  activeColor: Colors.white,
                  activeTrackColor: AppColors.primary,
                ),
                const SizedBox(width: 8),
                const Text('Custom prompt'),
              ],
            ),
          ),
          Positioned(
            right: 12,
            bottom: 12,
            child: Row(
              children: [
                if (_selectedImage != null)
                  IconButton(
                    onPressed: _removeImage,
                    icon: const Icon(Icons.close, color: Colors.white),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.red.withValues(alpha: 0.8),
                    ),
                  ),
                const SizedBox(width: 8),
                PrimaryButton(
                  label: _selectedImage != null ? 'Değiştir' : 'Resim Seç',
                  onPressed: _isUploading ? null : () => _pickImage(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    setState(() => _isUploading = true);

    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 600,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
          _isUploading = false;
        });
      } else {
        setState(() => _isUploading = false);
      }
    } catch (e) {
      setState(() => _isUploading = false);
      // Hata durumunda kullanıcıya bilgi ver
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Resim seçilirken hata oluştu: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _removeImage() {
    setState(() {
      _selectedImage = null;
    });
  }
}

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  const PrimaryButton({super.key, required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryVariant],
        ),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: onPressed,
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.w800)),
      ),
    );
  }
}

class ControlCard extends StatelessWidget {
  final Widget child;
  const ControlCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 82,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1.4),
      ),
      child: child,
    );
  }
}

class TileButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  const TileButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(icon),
          ],
        ),
      ),
    );
  }
}

class GenerateSectionTitle extends StatelessWidget {
  final String text;
  const GenerateSectionTitle(this.text, {super.key});
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
              image: AssetImage(
                AppImages.carImages[index % AppImages.carImages.length],
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}

class GenerateButton extends StatelessWidget {
  final VoidCallback onPressed;
  const GenerateButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: PrimaryButton(label: 'Generate ✨', onPressed: onPressed),
    );
  }
}

class SheetTitle extends StatelessWidget {
  final String text;
  const SheetTitle(this.text, {super.key});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
    );
  }
}

class ColorItem extends StatelessWidget {
  final Color color;
  final bool selected;
  final VoidCallback onTap;
  const ColorItem({
    super.key,
    required this.color,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? AppColors.primary : Colors.white24,
            width: selected ? 2 : 1,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Text(
              _hexOf(color),
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }

  String _hexOf(Color c) =>
      '#${c.toARGB32().toRadixString(16).substring(2).toUpperCase()}';
}

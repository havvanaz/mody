import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../app/app_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _timeline; // Tüm sahne için tek zaman çizelgesi
  late AnimationController _bgController; // Arka plan degrade nefes animasyonu
  late AnimationController _particleController; // Parçacık animasyonu

  // Başlık animasyonları
  late Animation<double> _titleFade; // 0.10 - 0.40
  late Animation<double> _titleBounce; // 0.10 - 0.50
  late Animation<double> _letterSpace; // 0.20 - 0.60
  late Animation<double> _titleGlow; // 0.30 - 0.70

  // Alt başlık animasyonları
  late Animation<double> _subtitleFade; // 0.40 - 0.70
  late Animation<double> _subtitleSlide; // 0.40 - 0.70

  // Logo animasyonları
  late Animation<double> _logoScale; // 0.15 - 0.45
  late Animation<double> _logoRotate; // 0.15 - 0.45

  // Parçacık animasyonları
  late Animation<double> _particleOpacity; // 0.20 - 0.80

  @override
  void initState() {
    super.initState();

    // 1) Zaman çizelgesi (toplam 6 saniye)
    _timeline = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    );

    // 2) Arka plan degrade “nefes” animasyonu (sonsuz)
    _bgController = AnimationController(
      duration: const Duration(milliseconds: 4000),
      vsync: this,
    )..repeat(reverse: true);

    // 3) Parçacık animasyonu (sonsuz)
    _particleController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..repeat();

    // 4) Başlık animasyonları (bounce efekti ile)
    _titleFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _timeline,
        curve: const Interval(0.10, 0.40, curve: Curves.easeOutCubic),
      ),
    );

    _titleBounce = Tween<double>(begin: 0.3, end: 1.2).animate(
      CurvedAnimation(
        parent: _timeline,
        curve: const Interval(0.10, 0.50, curve: Curves.elasticOut),
      ),
    );

    _letterSpace = Tween<double>(begin: 0, end: 4.0).animate(
      CurvedAnimation(
        parent: _timeline,
        curve: const Interval(0.20, 0.60, curve: Curves.easeOut),
      ),
    );

    _titleGlow = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _timeline,
        curve: const Interval(0.30, 0.70, curve: Curves.easeInOut),
      ),
    );

    // 5) Alt başlık animasyonları
    _subtitleFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _timeline,
        curve: const Interval(0.40, 0.70, curve: Curves.easeOut),
      ),
    );

    _subtitleSlide = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _timeline,
        curve: const Interval(0.40, 0.70, curve: Curves.easeOutCubic),
      ),
    );

    // 6) Logo animasyonları
    _logoScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _timeline,
        curve: const Interval(0.15, 0.45, curve: Curves.elasticOut),
      ),
    );

    _logoRotate = Tween<double>(begin: -0.2, end: 0.0).animate(
      CurvedAnimation(
        parent: _timeline,
        curve: const Interval(0.15, 0.45, curve: Curves.easeOutCubic),
      ),
    );

    // 7) Parçacık animasyonları
    _particleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _timeline,
        curve: const Interval(0.20, 0.80, curve: Curves.easeInOut),
      ),
    );

    // Animasyonu başlat
    _timeline.forward();

    // Bittiğinde yönlendir
    _timeline.addStatusListener((status) {
      if (status == AnimationStatus.completed && mounted) {
        context.go(AppRoutes.onboarding);
      }
    });
  }

  @override
  void dispose() {
    _timeline.dispose();
    _bgController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bg = _AnimatedGradientBackground(controller: _bgController);

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F16),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => context.go(AppRoutes.onboarding), // dokununca geç
        child: Stack(
          fit: StackFit.expand,
          children: [
            // 1) Canlı degrade arka plan
            AnimatedBuilder(
              animation: _bgController,
              builder: (_, __) => CustomPaint(painter: bg),
            ),

            // 2) hafif noise / film grain (çok düşük opaklık)
            IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withValues(alpha: 0.02),
                      Colors.transparent,
                      Colors.white.withValues(alpha: 0.02),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),

            // 3) İçerik
            SafeArea(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Logo animasyonu
                    AnimatedBuilder(
                      animation: _timeline,
                      builder: (context, _) {
                        return Opacity(
                          opacity: _logoScale.value,
                          child: Transform.scale(
                            scale: _logoScale.value,
                            child: Transform.rotate(
                              angle: _logoRotate.value,
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      AppColors.primary,
                                      AppColors.primaryVariant,
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primary.withValues(
                                        alpha: 0.5,
                                      ),
                                      blurRadius: 20,
                                      spreadRadius: 5,
                                    ),
                                  ],
                                ),
                                child: Image.asset(
                                  AppImages.transparentCar,
                                  width: 65,
                                  height: 65,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),

                    // Başlık animasyonu
                    AnimatedBuilder(
                      animation: _timeline,
                      builder: (context, _) {
                        return Opacity(
                          opacity: _titleFade.value,
                          child: Transform.scale(
                            scale: _titleBounce.value,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withValues(
                                      alpha: 0.3 * _titleGlow.value,
                                    ),
                                    blurRadius: 20 * _titleGlow.value,
                                    spreadRadius: 5 * _titleGlow.value,
                                  ),
                                ],
                              ),
                              child: Text(
                                'MODY AI',
                                style: Theme.of(context).textTheme.headlineLarge
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 48,
                                      letterSpacing: _letterSpace.value,
                                    ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    const SizedBox(height: 16),
                    AnimatedBuilder(
                      animation: _timeline,
                      builder: (context, _) {
                        return Opacity(
                          opacity: _subtitleFade.value,
                          child: Transform.translate(
                            offset: Offset(0, _subtitleSlide.value),
                            child: Text(
                              'Auto Modifikasyon • AI Powered',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: Colors.white.withValues(alpha: 0.8),
                                    letterSpacing: _letterSpace.value * 0.3,
                                  ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // 4) Parçacık efektleri
            AnimatedBuilder(
              animation: _particleController,
              builder: (context, _) {
                return Opacity(
                  opacity: _particleOpacity.value,
                  child: CustomPaint(
                    painter: _ParticlePainter(
                      controller: _particleController,
                      moveValue: _particleController.value,
                    ),
                    size: Size.infinite,
                  ),
                );
              },
            ),

            // 5) alt tarafta küçük bir progress çizgisi
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 28,
                ),
                child: AnimatedBuilder(
                  animation: _timeline,
                  builder: (context, _) {
                    final v = Curves.easeInOut.transform(
                      _timeline.value.clamp(0.0, 1.0),
                    );
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: LinearProgressIndicator(
                        value: v,
                        minHeight: 4,
                        backgroundColor: Colors.white.withValues(alpha: 0.08),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.primary.withValues(alpha: 0.8),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Arka plan için nefes alan degrade painter
class _AnimatedGradientBackground extends CustomPainter {
  final AnimationController controller;
  _AnimatedGradientBackground({required this.controller})
    : super(repaint: controller);

  @override
  void paint(Canvas canvas, Size size) {
    final t = controller.value;

    final c1 = Color.lerp(const Color(0xFF0B0F16), const Color(0xFF0E1830), t)!;
    final c2 = Color.lerp(const Color(0xFF0E1830), const Color(0xFF0B0F16), t)!;

    final rect = Offset.zero & size;
    final paint = Paint()
      ..shader = ui.Gradient.radial(
        Offset(size.width * 0.75, size.height * 0.25),
        size.shortestSide * (0.6 + 0.1 * (0.5 - (t - 0.5).abs() * 2)),
        [c1, c2],
        [0.0, 1.0],
      );

    canvas.drawRect(rect, paint);

    // Köşelerden çok hafif vignette
    final vignette = Paint()
      ..shader = ui.Gradient.radial(
        Offset(size.width * 0.5, size.height * 0.6),
        size.longestSide,
        [
          Colors.black.withValues(alpha: 0),
          Colors.black.withValues(alpha: 0.25),
        ],
        [0.6, 1.0],
      );
    canvas.drawRect(rect, vignette);
  }

  @override
  bool shouldRepaint(covariant _AnimatedGradientBackground oldDelegate) => true;
}

/// Parçacık efektleri için painter
class _ParticlePainter extends CustomPainter {
  final AnimationController controller;
  final double moveValue;

  _ParticlePainter({required this.controller, required this.moveValue})
    : super(repaint: controller);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;

    // Rastgele parçacıklar
    for (int i = 0; i < 15; i++) {
      final x = (i * 123.456) % size.width;
      final y = (i * 789.012) % size.height;
      final radius = 1.0 + (i % 3) * 0.5;

      final offset = Offset(
        x + (moveValue * 20 * (i % 2 == 0 ? 1 : -1)),
        y + (moveValue * 15 * (i % 3 == 0 ? 1 : -1)),
      );

      canvas.drawCircle(offset, radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) => true;
}

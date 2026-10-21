import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// Subtle Dart-syntax inspired decorations for the hero.
class CodeDecorations extends StatelessWidget {
  const CodeDecorations({super.key});

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontFamily: 'monospace',
          fontSize: 13,
          height: 1.55,
        );

    return IgnorePointer(
      child: Opacity(
        opacity: 0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '// portfolio.dart',
              style: base?.copyWith(color: AppColors.mutedText),
            ),
            const SizedBox(height: 4),
            Text.rich(
              TextSpan(
                style: base,
                children: const [
                  TextSpan(
                    text: 'void ',
                    style: TextStyle(color: AppColors.emerald),
                  ),
                  TextSpan(
                    text: 'main',
                    style: TextStyle(color: AppColors.offWhite),
                  ),
                  TextSpan(
                    text: '() {',
                    style: TextStyle(color: AppColors.mutedText),
                  ),
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                style: base,
                children: const [
                  TextSpan(text: '  '),
                  TextSpan(
                    text: 'runApp',
                    style: TextStyle(color: AppColors.offWhite),
                  ),
                  TextSpan(
                    text: '(',
                    style: TextStyle(color: AppColors.mutedText),
                  ),
                  TextSpan(
                    text: 'PortfolioApp',
                    style: TextStyle(color: AppColors.emerald),
                  ),
                  TextSpan(
                    text: '());',
                    style: TextStyle(color: AppColors.mutedText),
                  ),
                ],
              ),
            ),
            Text(
              '}',
              style: base?.copyWith(color: AppColors.mutedText),
            ),
          ],
        ),
      ),
    );
  }
}

/// Soft Flutter-inspired abstract geometry behind the hero.
class FlutterGeometryBackdrop extends StatelessWidget {
  const FlutterGeometryBackdrop({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: CustomPaint(
        painter: _FlutterGeometryPainter(),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _FlutterGeometryPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = AppColors.emerald.withValues(alpha: 0.18);

    final fill = Paint()
      ..style = PaintingStyle.fill
      ..color = AppColors.emerald.withValues(alpha: 0.05);

    final origin = Offset(size.width * 0.72, size.height * 0.35);
    canvas.drawCircle(origin, size.shortestSide * 0.22, fill);
    canvas.drawCircle(origin, size.shortestSide * 0.22, paint);
    canvas.drawCircle(origin, size.shortestSide * 0.34, paint);

    final path = Path()
      ..moveTo(size.width * 0.58, size.height * 0.15)
      ..lineTo(size.width * 0.88, size.height * 0.42)
      ..lineTo(size.width * 0.62, size.height * 0.72)
      ..close();
    canvas.drawPath(path, paint);

    canvas.drawLine(
      Offset(size.width * 0.55, size.height * 0.8),
      Offset(size.width * 0.92, size.height * 0.55),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

import 'dart:ui';

import 'package:flutter/material.dart';

/// A custom painter that draws a dotted (or dashed) border around a shape.
///
/// The border is drawn using a [Path] and segmented into small strokes
/// separated by gaps defined by [dotSpacing].
class DottedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dotSpacing;
  final double radius;

  /// Creates a dotted border painter.
  ///
  /// [color] defines the border color.
  /// [strokeWidth] defines the thickness of each dot/dash.
  /// [dotSpacing] defines the spacing between dots/dashes.
  /// [radius] defines the corner radius of the border.
  DottedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.dotSpacing,
    this.radius = 0.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint =
        Paint()
          ..color = color
          ..strokeWidth = strokeWidth
          ..strokeJoin = StrokeJoin.round
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke;

    final Path path =
        Path()..addRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(0, 0, size.width, size.height),
            Radius.circular(radius),
          ),
        );

    final PathMetrics pathMetrics = path.computeMetrics();

    for (final PathMetric pathMetric in pathMetrics) {
      double distance = 0.0;

      while (distance < pathMetric.length) {
        final double dashLength = strokeWidth;
        final double gapLength = dotSpacing;
        final double totalLength = dashLength + gapLength;

        final double currentDashLength =
            distance + dashLength < pathMetric.length
                ? dashLength
                : pathMetric.length - distance;

        final Path extractPath = pathMetric.extractPath(
          distance,
          distance + currentDashLength,
        );

        canvas.drawPath(extractPath, paint);
        distance += totalLength;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

/// A widget that draws a dotted border around its [child].
///
/// This widget uses [CustomPaint] to render a dotted border effect
/// without affecting the layout of the child widget.
class DottedBorder extends StatelessWidget {
  const DottedBorder({
    super.key,
    required this.child,
    this.color = Colors.grey,
    this.strokeWidth = 1.0,
    this.radius = 0.0,
    this.dotSpacing = 4.0,
  });

  /// The widget inside the dotted border.
  final Widget child;

  /// Color of the dotted border.
  final Color color;

  /// Thickness of each dot/dash in the border.
  final double strokeWidth;

  /// Corner radius of the border.
  final double radius;

  /// Space between each dot/dash.
  final double dotSpacing;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: DottedBorderPainter(
        color: color,
        strokeWidth: strokeWidth,
        radius: radius,
        dotSpacing: dotSpacing,
      ),
      child: child,
    );
  }
}

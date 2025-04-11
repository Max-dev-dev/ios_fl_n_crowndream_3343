import 'dart:math';
import 'package:flutter/material.dart';

class SleepCirclePainter extends CustomPainter {
  final TimeOfDay? bedtime;
  final TimeOfDay? wakeUpTime;

  SleepCirclePainter({this.bedtime, this.wakeUpTime});

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2;

    // Circle background
    final paintCircle =
        Paint()
          ..color = Colors.brown.withOpacity(0.2)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 14;

    canvas.drawCircle(center, radius, paintCircle);

    // Sleep arc
    if (bedtime != null && wakeUpTime != null) {
      final startAngle = _timeToAngle(bedtime!);
      final endAngle = _timeToAngle(wakeUpTime!);
      final sweepAngle = (endAngle - startAngle + 2 * pi) % (2 * pi);

      final paintArc =
          Paint()
            ..shader = const SweepGradient(
              colors: [Color(0xFFF1B016), Color(0xFFFFE898)],
            ).createShader(Rect.fromCircle(center: center, radius: radius))
            ..style = PaintingStyle.stroke
            ..strokeWidth = 14
            ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle - pi / 2,
        sweepAngle,
        false,
        paintArc,
      );
    }

    textPainter(String text) {
      final tp = TextPainter(
        text: TextSpan(
          text: text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      return tp;
    }

    final hourLabels = {'0': -pi / 2, '6': 0, '12': pi / 2, '18': pi};

    hourLabels.forEach((label, angle) {
      final labelRadius = radius + 20;
      final offset = Offset(
        center.dx + labelRadius * cos(angle),
        center.dy + labelRadius * sin(angle),
      );

      final tp = textPainter(label);
      final position = offset - Offset(tp.width / 2, tp.height / 2);
      tp.paint(canvas, position);
    });
  }

  double _timeToAngle(TimeOfDay time) {
    final totalMinutes = time.hour * 60 + time.minute;
    return (2 * pi * totalMinutes / 1440);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

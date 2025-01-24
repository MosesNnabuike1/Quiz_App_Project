import 'package:flutter/material.dart';

class ProgressCircle extends StatelessWidget {
  final double progress;

  const ProgressCircle({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: progress),
        duration: const Duration(milliseconds: 100),
        builder: (context, value, _) => Stack(
          fit: StackFit.expand,
          children: [
            Center(
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 219, 214, 214),
                ),
              ),
            ),
            CircularProgressIndicator(
              value: value,
              strokeWidth: 8,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
              backgroundColor: Colors.grey[300],
            ),
            Center(
              child: Text(
                '${(value * 100).toInt()}%',
                style: const TextStyle(fontSize: 12, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

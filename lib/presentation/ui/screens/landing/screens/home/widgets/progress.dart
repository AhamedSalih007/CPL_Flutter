import 'package:flutter/material.dart';

class GlowProgressBar extends StatelessWidget {
  final double progress; // 0.0 to 1.0

  const GlowProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          // Background bar
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
          ),

          // Progress bar
          FractionallySizedBox(
            widthFactor: progress,
            child: Container(
              height: 8,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.purpleAccent, Colors.deepPurpleAccent],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purpleAccent.withOpacity(0.8),
                    blurRadius: 20,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
          ),

          // Circle at end
          Positioned(
            left: MediaQuery.of(context).size.width * progress - 10,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.purpleAccent,
                boxShadow: [
                  BoxShadow(
                    color: Colors.purpleAccent.withOpacity(0.8),
                    blurRadius: 15,
                    spreadRadius: 3,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

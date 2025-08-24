import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../../../../core/utils/styles/dimensions/ui_dimensions.dart';
import '../../../../../../providers/tracker_steps/tracker_steps_provider.dart';
import '../../../../../../../core/utils/assets_gen/fonts.gen.dart';

class Tracker extends ConsumerWidget {
  const Tracker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trackerAsync = ref.watch(trackerProvider);

    return SafeArea(
      child: Center(
        child: Column(
          children: [
            Text(
              "STEP CHALLENGE TRACKER",
              style: TextStyle(
                fontSize: UIDimensions.font20,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
                fontFamily: FontFamily.cplt20,
              ),
            ),
            Container(
              margin: UIDimensions.allPaddingInsets(16),
              padding: UIDimensions.allPaddingInsets(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.deepOrange, width: 1),
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xFF0C0D2C),
              ),
              child: trackerAsync.when(
                data: (stepsData) {
                  if (stepsData.isEmpty) {
                    return const Text("No data available",
                        style: TextStyle(color: Colors.white));
                  }

                  // find max value and scale
                  final int maxValue = stepsData
                      .map((t) => t.count)
                      .reduce((a, b) => a > b ? a : b);
                  final double adjustedMaxValue = maxValue * 1.2;

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 20),
                      Column(
                        children: stepsData.map((team) {
                          final progress =
                              (team.count / adjustedMaxValue).clamp(0.0, 1.0);

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  width:
                                      MediaQuery.of(context).size.width * 0.12,
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1A1B3C),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Colors.white38,
                                      width: 2,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Image.network(
                                      team.logoUrl,
                                      fit: BoxFit.contain,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Icon(Icons.error,
                                                  color: Colors.red, size: 24),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.02, // 3% of screen width
                                ),
                                Expanded(
                                  child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      final barWidth =
                                          constraints.maxWidth * progress;

                                      return Stack(
                                        children: [
                                          // Background
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01,
                                            decoration: BoxDecoration(
                                              color: Colors.purple
                                                  .withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),

                                          // Foreground (filled bar)
                                          AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01,
                                            width: barWidth,
                                            decoration: const BoxDecoration(
                                              color: Colors.purpleAccent,
                                              borderRadius:
                                                  BorderRadius.horizontal(
                                                left: Radius.circular(10),
                                                right: Radius.circular(
                                                    10), // rounded end
                                              ),
                                            ),
                                          ),

                                          // End Circle
                                          Positioned(
                                            left: barWidth - 8,
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color.fromARGB(
                                                    255, 222, 106, 243),
                                                boxShadow: [
                                                  BoxShadow(
                                                    // color: Colors.purpleAccent
                                                    //     .withOpacity(0.6),
                                                    blurRadius: 10,
                                                    spreadRadius: 2,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.height *
                                        0.02),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    NumberFormat.decimalPattern()
                                        .format(team.count),
                                    style: TextStyle(
                                      fontSize: UIDimensions.font12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: MediaQuery.of(context).size.height *
                            0.15, // increase height
                        width: MediaQuery.of(context).size.width *
                            0.55, // increase width
                        child: Image.network(
                          "https://www.cplt20.com/assets/images/party.png",
                          fit: BoxFit.contain, // maintains aspect ratio
                        ),
                      ),
                    ],
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(
                    child: Text("Error: $err",
                        style: const TextStyle(color: Colors.red))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

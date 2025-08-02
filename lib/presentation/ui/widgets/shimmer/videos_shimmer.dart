import 'package:flutter/widgets.dart';

import '../../../../core/utils/extensions/context_extension.dart';
import '../../../../core/utils/styles/dimensions/ui_dimensions.dart';
import 'common_shimmer.dart';

class VideosShimmer extends StatelessWidget {
  final Axis axisDirection;
  const VideosShimmer({super.key, this.axisDirection = Axis.vertical});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: UIDimensions.symmetricPaddingInsets(horizontal: 12),
      child: (axisDirection == Axis.vertical)
          ? GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              childAspectRatio: 1.6,
              mainAxisSpacing: 5,
              shrinkWrap: true,
              children: [
                ...List.generate(
                  10,
                  (index) => const CommonShimmer(height: 120, width: 200),
                ),
              ],
            )
          : SizedBox(
              width: context.screenWidth,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...List.generate(
                        4,
                        (index) => Padding(
                              padding:
                                  UIDimensions.onlyPaddingInsets(right: 12.0),
                              child:
                                  const CommonShimmer(height: 120, width: 220),
                            ))
                  ],
                ),
              ),
            ),
    );
  }
}

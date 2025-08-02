import 'package:flutter/material.dart';
import '../../../../core/utils/extensions/context_extension.dart';
import '../../../../core/utils/styles/dimensions/ui_dimensions.dart';
import 'common_shimmer.dart';

class MatchesShimmer extends StatelessWidget {
  final Axis scrollDirection;
  const MatchesShimmer({super.key, this.scrollDirection = Axis.vertical});

  @override
  Widget build(BuildContext context) {
    return (scrollDirection == Axis.vertical)
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, index) {
              return matchContainerShimmer(context);
            },
          )
        : SizedBox(
            width: context.screenWidth,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...List.generate(
                      3, (index) => matchContainerShimmer(context)),
                ],
              ),
            ),
          );
  }
}

Widget matchContainerShimmer(BuildContext context) {
  return Padding(
    padding: UIDimensions.onlyPaddingInsets(bottom: 8, left: 16, right: 16),
    child: Container(
      width: context.screenWidth * 0.85,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: context.customColors.grey3Color ?? Colors.transparent)),
      child: Padding(
        padding: UIDimensions.allPaddingInsets(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonShimmer(height: 30, width: 100),
                CommonShimmer(height: 30, width: 100)
              ],
            ),
            UIDimensions.verticalSpaceMedium,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SizedBox(
                    width: context.screenWidth * 0.32,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        UIDimensions.horizontalSpaceSmall,
                        Column(
                          children: [
                            CommonShimmer(
                              height: 47,
                              width: 47,
                              cornerRadius: 999,
                            ),
                            UIDimensions.verticalSpaceSmall,
                            CommonShimmer(height: 10, width: 50)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  child: SizedBox(
                    width: context.screenWidth * 0.32,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        UIDimensions.horizontalSpaceSmall,
                        Column(
                          children: [
                            CommonShimmer(
                              height: 47,
                              width: 47,
                              cornerRadius: 999,
                            ),
                            UIDimensions.verticalSpaceSmall,
                            CommonShimmer(height: 10, width: 50)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            UIDimensions.verticalSpaceSmall,
            const Divider(
              color: Color.fromRGBO(255, 255, 255, 0.3),
            ),
            UIDimensions.verticalSpaceSmall,
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonShimmer(height: 30, width: 100),
                CommonShimmer(height: 30, width: 100)
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

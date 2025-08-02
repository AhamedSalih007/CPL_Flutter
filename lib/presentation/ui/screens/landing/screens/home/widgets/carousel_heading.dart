import 'package:flutter/widgets.dart';

import '../../../../../../../core/utils/assets_gen/fonts.gen.dart';
import '../../../../../../../core/utils/extensions/context_extension.dart';
import '../../../../../../../core/utils/styles/dimensions/ui_dimensions.dart';
import '../../../../../widgets/custom_text.dart';

class CarouselHeading extends StatelessWidget {
  final String title;
  final String subTitle;
  final String quote;
  final Color titleColor;
  final Color subTitleColor;
  const CarouselHeading({
    super.key,
    required this.title,
    required this.subTitle,
    required this.quote,
    required this.titleColor,
    required this.subTitleColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: context.screenWidth * 0.9,
            child: CustomText.displayMedium(
              title.toUpperCase(),
              color: titleColor,
              fontFamily: FontFamily.cplt20,
              maxLines: 2,
              textOverflow: TextOverflow.ellipsis,
            ),
          ),
          if (subTitle.isNotEmpty) ...[
            SizedBox(
              width: context.screenWidth * 0.9,
              child: CustomText.displayLarge(
                subTitle.toUpperCase(),
                color: subTitleColor,
                fontFamily: FontFamily.cplt20,
                maxLines: 1,
                textOverflow: TextOverflow.ellipsis,
              ),
            ),
            UIDimensions.verticalSpaceSmall,
          ],
          SizedBox(
            width: context.screenWidth * 0.9,
            child: CustomText.bodyMedium(
              quote,
              color: context.colorScheme.onSurface,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}

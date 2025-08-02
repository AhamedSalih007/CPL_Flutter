import 'package:flutter/widgets.dart';
import '../../../core/utils/assets_gen/fonts.gen.dart';
import '../../../core/utils/styles/dimensions/ui_dimensions.dart';
import 'clickable_arrow.dart';
import 'custom_text.dart';

class Header extends StatelessWidget {
  final String title;
  final String? subTitle;
  final Color titleColor;
  final Color subTitleColor;
  final Color arrowColor;
  final int? arrowCount;
  final void Function()? onTap;
  const Header(
      {super.key,
      required this.title,
      this.subTitle,
      required this.titleColor,
      required this.subTitleColor,
      required this.arrowColor,
      this.arrowCount,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: UIDimensions.symmetricPaddingInsets(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText.displayMedium(
                title.toUpperCase(),
                color: titleColor,
                fontFamily: FontFamily.cplt20,
              ),
              if (subTitle != null && subTitle!.isNotEmpty)
                CustomText.displayLarge(
                  subTitle!.toUpperCase(),
                  color: subTitleColor,
                  fontFamily: FontFamily.cplt20,
                ),
            ],
          ),
          ClickableArrow(
            color: arrowColor,
            itemCount: arrowCount,
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}

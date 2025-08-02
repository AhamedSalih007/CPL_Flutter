import 'package:flutter/material.dart';

//?Use this custom color from context extensions customColors getter
@immutable
class UICustomColors extends ThemeExtension<UICustomColors> {
  const UICustomColors({
    required this.font28Color,
    required this.font24Color,
    required this.font20Color,
    required this.font18Color,
    required this.font16Color,
    required this.font14Color,
    required this.font12Color,
    required this.whiteColor,
    required this.blackColor,
    required this.redColor,
    required this.greenColor,
    required this.greyColor,
    required this.marinerColor,
    required this.loadingIndicatorColor,
    required this.primaryBoxGradient,
    required this.secondaryYellow,
    required this.secondaryRed,
    required this.secondaryOrange,
    required this.grey2Color,
    required this.grey3Color,
    required this.grey4Color,
    required this.grey5Color,
    required this.white10Color,
    required this.white20Color,
    required this.black40Color,
    required this.primaryPurple,
    required this.textColor,
    required this.black10Color,
    required this.purpleVariant,
    required this.blueVarient,
    required this.purpleVariant2,
  });

  final Color? font28Color;
  final Color? font24Color;
  final Color? font20Color;
  final Color? font18Color;
  final Color? font16Color;
  final Color? font14Color;
  final Color? font12Color;
  final Color? whiteColor;
  final Color? blackColor;
  final Color? redColor;
  final Color? greenColor;
  final Color? greyColor;
  final Color? marinerColor;
  final Color? loadingIndicatorColor;
  final LinearGradient? primaryBoxGradient;
  final Color? secondaryYellow;
  final Color? secondaryRed;
  final Color? secondaryOrange;
  final Color? grey2Color;
  final Color? grey3Color;
  final Color? grey4Color;
  final Color? grey5Color;
  final Color? white10Color;
  final Color? white20Color;
  final Color? black40Color;
  final Color? primaryPurple;
  final Color? textColor;
  final Color? black10Color;
  final Color? purpleVariant;
  final Color? purpleVariant2;
  final Color? blueVarient;

  @override
  UICustomColors copyWith({
    Color? font40Color,
    Color? font28Color,
    Color? font24Color,
    Color? font20Color,
    Color? font18Color,
    Color? font16Color,
    Color? font14Color,
    Color? font12Color,
    Color? whiteColor,
    Color? blackColor,
    Color? redColor,
    Color? greenColor,
    Color? greyColor,
    Color? orangeColor,
    Color? marinerColor,
    Color? loadingIndicatorColor,
    LinearGradient? primaryBoxGradient,
    Color? secondaryYellow,
    Color? secondaryRed,
    Color? secondaryOrange,
    Color? grey2Color,
    Color? grey3Color,
    Color? grey4Color,
    Color? grey5Color,
    Color? white10Color,
    Color? white20Color,
    Color? black40Color,
    Color? primaryPurple,
    Color? textColor,
    Color? black10Color,
    Color? purpleVariant,
    Color? purpleVariant2,
    Color? blueVarient,
  }) {
    return UICustomColors(
      font28Color: font28Color ?? this.font28Color,
      font24Color: font24Color ?? this.font24Color,
      font20Color: font20Color ?? this.font20Color,
      font18Color: font18Color ?? this.font18Color,
      font16Color: font16Color ?? this.font16Color,
      font14Color: font14Color ?? this.font14Color,
      font12Color: font12Color ?? this.font12Color,
      whiteColor: whiteColor ?? this.whiteColor,
      blackColor: blackColor ?? this.blackColor,
      redColor: redColor ?? this.redColor,
      greenColor: greenColor ?? this.greenColor,
      greyColor: greyColor ?? this.greyColor,
      marinerColor: marinerColor ?? this.marinerColor,
      loadingIndicatorColor:
          loadingIndicatorColor ?? this.loadingIndicatorColor,
      primaryBoxGradient: primaryBoxGradient ?? this.primaryBoxGradient,
      secondaryYellow: secondaryYellow ?? this.secondaryYellow,
      secondaryRed: secondaryRed ?? this.secondaryRed,
      secondaryOrange: secondaryOrange ?? this.secondaryOrange,
      grey2Color: grey2Color ?? this.grey2Color,
      grey3Color: grey3Color ?? this.grey3Color,
      grey4Color: grey4Color ?? this.grey4Color,
      grey5Color: grey5Color ?? this.grey5Color,
      white10Color: white10Color ?? this.white10Color,
      white20Color: white20Color ?? this.white20Color,
      black40Color: black40Color ?? this.black40Color,
      primaryPurple: primaryPurple ?? this.primaryPurple,
      textColor: textColor ?? this.textColor,
      black10Color: black10Color ?? this.black10Color,
      purpleVariant: purpleVariant ?? this.purpleVariant,
      purpleVariant2: purpleVariant2 ?? this.purpleVariant2,
      blueVarient: blueVarient ?? this.blueVarient,
    );
  }

  // Controls how the properties change on theme changes
  @override
  UICustomColors lerp(ThemeExtension<UICustomColors>? other, double t) {
    if (other is! UICustomColors) {
      return this;
    }
    return UICustomColors(
      font28Color: Color.lerp(font28Color, other.font28Color, t),
      font24Color: Color.lerp(font24Color, other.font24Color, t),
      font20Color: Color.lerp(font20Color, other.font20Color, t),
      font18Color: Color.lerp(font18Color, other.font18Color, t),
      font16Color: Color.lerp(font16Color, other.font16Color, t),
      font14Color: Color.lerp(font14Color, other.font14Color, t),
      font12Color: Color.lerp(font12Color, other.font12Color, t),
      whiteColor: Color.lerp(whiteColor, other.whiteColor, t),
      blackColor: Color.lerp(blackColor, other.blackColor, t),
      redColor: Color.lerp(redColor, other.redColor, t),
      greenColor: Color.lerp(greenColor, other.greenColor, t),
      greyColor: Color.lerp(greyColor, other.greyColor, t),
      marinerColor: Color.lerp(marinerColor, other.marinerColor, t),
      loadingIndicatorColor:
          Color.lerp(loadingIndicatorColor, other.loadingIndicatorColor, t),
      secondaryYellow: Color.lerp(secondaryYellow, other.secondaryYellow, t),
      secondaryRed: Color.lerp(secondaryRed, other.secondaryRed, t),
      secondaryOrange: Color.lerp(secondaryOrange, other.secondaryOrange, t),
      grey2Color: Color.lerp(grey2Color, other.grey2Color, t),
      grey3Color: Color.lerp(grey3Color, other.grey3Color, t),
      grey4Color: Color.lerp(grey4Color, other.grey4Color, t),
      grey5Color: Color.lerp(grey5Color, other.grey5Color, t),
      white10Color: Color.lerp(white10Color, other.white10Color, t),
      white20Color: Color.lerp(white20Color, other.white20Color, t),
      black40Color: Color.lerp(black40Color, other.black40Color, t),
      primaryPurple: Color.lerp(primaryPurple, other.primaryPurple, t),
      black10Color: Color.lerp(black10Color, other.black10Color, t),
      textColor: Color.lerp(textColor, other.textColor, t),
      purpleVariant: Color.lerp(purpleVariant, other.purpleVariant, t),
      purpleVariant2: Color.lerp(purpleVariant2, other.purpleVariant2, t),
      blueVarient: Color.lerp(blueVarient, other.blueVarient, t),
      primaryBoxGradient:
          LinearGradient.lerp(primaryBoxGradient, other.primaryBoxGradient, t),
    );
  }

  @override
  String toString() {
    return 'UICustomColors(font28Color: $font28Color, font24Color: $font24Color, font20Color: $font20Color, font18Color: $font18Color, font16Color: $font16Color, font14Color: $font14Color, font12Color: $font12Color, whiteColor: $whiteColor, blackColor: $blackColor, redColor: $redColor, greenColor: $greenColor, greyColor: $greyColor, marinerColor: $marinerColor, loadingIndicatorColor: $loadingIndicatorColor)';
  }
}

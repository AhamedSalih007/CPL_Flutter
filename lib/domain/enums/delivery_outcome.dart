enum DeliveryOutcome {
  four("4", 0xffF57C00, 0xff0A0A32, 0xffF57C00),
  six("6", 0xffAFF711, 0xff0A0A32, 0xffAFF711),
  wicket("W", 0xffCA0000, 0xffE3DDF3, 0xffCA0000),
  other("0", 0xff0A0A32, 0xffE3DDF3, 0xffE3DDF3);

  final String val;
  final int backgroundColor;
  final int foreGroundColor;
  final int borderColor;
  const DeliveryOutcome(
      this.val, this.backgroundColor, this.foreGroundColor, this.borderColor);
}

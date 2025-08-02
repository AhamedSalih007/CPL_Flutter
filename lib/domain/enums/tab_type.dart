enum TabType {
  homeTab(0, 0xff6F45E9),
  matches(1, 0xff3FD8F9),
  teams(2, 0xffAFF711),
  news(3, 0xffF57C00);

  final int val;
  final int color;
  const TabType(this.val, this.color);
}

enum StateOfPlay {
  live("Live"),
  completed("Completed"),
  postPoned("Drinks"),
  cancelled("Lunch"),
  tea("Tea"),
  stumps("Stumps"),
  rainDelay("Rain Delay"),
  badLight("Bad Light"),
  inningsChange("Innings Change"),
  breakInPlay("Break in Play");

  final String val;
  const StateOfPlay(this.val);
}

enum MatchStatus {
  live("Live"),
  upcoming("Upcoming"),
  completed("Completed"),
  postPoned("Postponed"),
  cancelled("Cancelled");

  final String val;
  const MatchStatus(this.val);
}

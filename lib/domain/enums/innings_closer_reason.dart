enum InningsCloserReason {
  declared("Declared"),
  targetReached("Target Reached"),
  allOut("All Out"),
  compulsoryClose("Compulsory Close"),
  forfeit("Forfeit");

  final String val;
  const InningsCloserReason(this.val);
}

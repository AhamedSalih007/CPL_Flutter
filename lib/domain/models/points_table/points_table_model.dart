class PointsTableModel {
  String position;
  String teamLogo;
  String matches;
  String wins;
  String losses;
  String nrr;
  String points;
  String? teamName;

  PointsTableModel(
      {required this.position,
      required this.teamLogo,
      required this.matches,
      required this.wins,
      required this.losses,
      required this.nrr,
      required this.points,
      this.teamName});
}

import '../../enums/roles.dart';

class ScoreCardModel {
  String name;
  String? runs;
  String? balls;
  String? fours;
  String? sixes;
  String? strikeRate;
  String? dots;
  String? maiden;
  String? wickets;
  String? economy;
  Role? role;
  String? status;

  ScoreCardModel(
      {required this.name,
      this.runs,
      this.balls,
      this.fours,
      this.sixes,
      this.strikeRate,
      this.dots,
      this.maiden,
      this.wickets,
      this.economy,
      this.role,
      this.status});
}

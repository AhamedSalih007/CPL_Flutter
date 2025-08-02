import '../../enums/match_status.dart';

class MatchModel {
  int id;
  MatchStatus matchStatus;
  MatchModel({required this.matchStatus, required this.id});
}

import '../../../domain/enums/match_status.dart';
import '../../../domain/models/match/match.dart';

List<MatchModel> matches = [
  MatchModel(matchStatus: MatchStatus.live, id: 1),
  MatchModel(matchStatus: MatchStatus.completed, id: 2),
  MatchModel(matchStatus: MatchStatus.upcoming, id: 3),
  MatchModel(matchStatus: MatchStatus.completed, id: 4),
  MatchModel(matchStatus: MatchStatus.completed, id: 5),
  MatchModel(matchStatus: MatchStatus.completed, id: 6),
  MatchModel(matchStatus: MatchStatus.completed, id: 7),
  MatchModel(matchStatus: MatchStatus.upcoming, id: 8),
  MatchModel(matchStatus: MatchStatus.upcoming, id: 9),
  MatchModel(matchStatus: MatchStatus.upcoming, id: 10),
];

List<MatchModel> liveMatches = [
  MatchModel(matchStatus: MatchStatus.live, id: 1),
  MatchModel(matchStatus: MatchStatus.live, id: 2),
  MatchModel(matchStatus: MatchStatus.live, id: 3),
  MatchModel(matchStatus: MatchStatus.live, id: 4)
];

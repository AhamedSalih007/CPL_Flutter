import '../../../core/utils/api/request_body.dart';

class MatchesReqbody extends RequestBody {
  String? teamId;
  String? venueId;
  String? competetions;
  MatchesReqbody({this.teamId, this.venueId, this.competetions});

  @override
  Map<String, dynamic> toJson() => {
        'team': teamId,
        'venue': venueId,
        "competitions": competetions,
      };
}

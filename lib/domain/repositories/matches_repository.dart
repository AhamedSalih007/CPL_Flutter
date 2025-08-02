import 'package:dio/dio.dart';

import '../../data/models/request_body/matches_req_body.dart';
import '../../data/models/result/data_state.dart';
import '../models/match_details/match_details.dart';

abstract interface class MatchesRepository {
  Future<DataState<List<MatchDetails>>> getMatches({
    String? clientKey,
    required MatchesReqbody matchesReqbody,
    CancelToken? cancelToken,
  });
  Future<DataState<MatchDetails>> getMatchSummary(
      {String? clientKey, required String matchId, CancelToken? cancelToken});
  Future<DataState<MatchDetails>> scoreCard(
      {String? clientKey, required String matchId, CancelToken? cancelToken});
  Future<DataState<MatchDetails>> getCommentary(
      {String? clientKey,
      required String matchId,
      required String inningsId,
      CancelToken? cancelToken});
}

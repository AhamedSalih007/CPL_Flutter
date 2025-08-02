import 'package:dio/dio.dart';

import '../../core/utils/api/response/api_response.dart';
import '../../domain/models/match_details/match_details.dart';
import '../../domain/repositories/matches_repository.dart';
import '../data_source/remote/matches_remote_data_source.dart';
import '../models/api/match_details/match_details_api_dto.dart';
import '../models/request_body/matches_req_body.dart';
import '../models/result/data_state.dart';

class MatchesRepositoryImpl implements MatchesRepository {
  final MatchesRemoteDataSource _matchesRemoteDataSource;
  MatchesRepositoryImpl(this._matchesRemoteDataSource);

  @override
  Future<DataState<MatchDetails>> getMatchSummary(
      {String? clientKey,
      required String matchId,
      CancelToken? cancelToken}) async {
    final matchDetails = await _matchesRemoteDataSource.getMatchSummary(
        matchId: matchId, cancelToken: cancelToken, clientKey: clientKey);
    switch (matchDetails) {
      case ApiResponseSuccess<MatchDetailsApiDto>(data: MatchDetailsApiDto res):
        return DataStateSuccess(res.toModel());
      case ApiResponseError<MatchDetailsApiDto>(ex: var ex):
        return DataStateError(ex);
    }
  }

  @override
  Future<DataState<List<MatchDetails>>> getMatches(
      {String? clientKey,
      required MatchesReqbody matchesReqbody,
      CancelToken? cancelToken}) async {
    final sponsorsResp = await _matchesRemoteDataSource.getMatches(
        matchesReqBody: matchesReqbody,
        cancelToken: cancelToken,
        clientKey: clientKey);
    switch (sponsorsResp) {
      case ApiResponseSuccess<List<MatchDetailsApiDto>>(
          data: List<MatchDetailsApiDto> res
        ):
        return DataStateSuccess(res.map((e) => e.toModel()).toList());
      case ApiResponseError<List<MatchDetailsApiDto>>(ex: var ex):
        return DataStateError(ex);
    }
  }

  @override
  Future<DataState<MatchDetails>> scoreCard(
      {String? clientKey,
      required String matchId,
      CancelToken? cancelToken}) async {
    final matchDetails = await _matchesRemoteDataSource.scoreCard(
        matchId: matchId, cancelToken: cancelToken, clientKey: clientKey);
    switch (matchDetails) {
      case ApiResponseSuccess<MatchDetailsApiDto>(data: MatchDetailsApiDto res):
        return DataStateSuccess(res.toModel());
      case ApiResponseError<MatchDetailsApiDto>(ex: var ex):
        return DataStateError(ex);
    }
  }

  @override
  Future<DataState<MatchDetails>> getCommentary(
      {String? clientKey,
      required String matchId,
      required String inningsId,
      CancelToken? cancelToken}) async {
    final matchDetails = await _matchesRemoteDataSource.getCommentary(
        matchId: matchId,
        cancelToken: cancelToken,
        clientKey: clientKey,
        inningsId: inningsId);
    switch (matchDetails) {
      case ApiResponseSuccess<MatchDetailsApiDto>(data: MatchDetailsApiDto res):
        return DataStateSuccess(res.toModel());
      case ApiResponseError<MatchDetailsApiDto>(ex: var ex):
        return DataStateError(ex);
    }
  }
}

import 'package:dio/dio.dart';

import '../../../core/configs/app_configuration.dart';
import '../../../core/utils/api/api_manager/api_manager.dart';
import '../../../core/utils/api/request_type.dart';
import '../../../core/utils/api/response/api_response.dart';
import '../../enums/endpoints.dart';
import '../../models/api/match_details/match_details_api_dto.dart';
import '../../models/request_body/matches_req_body.dart';

class MatchesRemoteDataSource {
  final ApiManager _apiManager;
  MatchesRemoteDataSource(this._apiManager);

  Future<ApiResponse<List<MatchDetailsApiDto>>> getMatches({
    String? clientKey,
    MatchesReqbody? matchesReqBody,
    CancelToken? cancelToken,
  }) async {
    return await _apiManager.requestListAsync<MatchDetailsApiDto>(
      requestType: RequestType.get,
      endpoint: EndPoints.matches.val(),
      newBaseUrl: AppConfiguration.radarBaseUrl,
      headers: {
        "sr-client-key": clientKey,
      },
      cancelToken: cancelToken,
      queryParams: matchesReqBody?.toJson(),
    );
  }

  Future<ApiResponse<MatchDetailsApiDto>> getMatchSummary({
    String? clientKey,
    required String matchId,
    CancelToken? cancelToken,
  }) async {
    return await _apiManager.requestAsync<MatchDetailsApiDto>(
      requestType: RequestType.get,
      endpoint: EndPoints.matchDetails.val(data: matchId),
      newBaseUrl: AppConfiguration.radarBaseUrl,
      headers: {
        "sr-client-key": clientKey,
      },
      cancelToken: cancelToken,
    );
  }

  Future<ApiResponse<MatchDetailsApiDto>> scoreCard({
    String? clientKey,
    required String matchId,
    CancelToken? cancelToken,
  }) async {
    return await _apiManager.requestAsync<MatchDetailsApiDto>(
      requestType: RequestType.get,
      endpoint: EndPoints.scorecard.val(data: matchId),
      newBaseUrl: AppConfiguration.radarBaseUrl,
      headers: {
        "sr-client-key": clientKey,
      },
      cancelToken: cancelToken,
    );
  }

  Future<ApiResponse<MatchDetailsApiDto>> getCommentary({
    String? clientKey,
    required String matchId,
    required String inningsId,
    CancelToken? cancelToken,
  }) async {
    return await _apiManager.requestAsync<MatchDetailsApiDto>(
      requestType: RequestType.get,
      endpoint: EndPoints.commentary.val(data: matchId),
      newBaseUrl: AppConfiguration.radarBaseUrl,
      headers: {
        "sr-client-key": clientKey,
      },
      queryParams: {
        "inningsId": inningsId,
      },
      cancelToken: cancelToken,
    );
  }
}

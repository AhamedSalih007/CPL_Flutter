import '../../../core/configs/app_configuration.dart';
import '../../../core/utils/api/api_manager/api_manager.dart';
import '../../../core/utils/api/request_type.dart';
import '../../../core/utils/api/response/api_response.dart';
import '../../enums/endpoints.dart';
import '../../models/api/competitions/competitions_api_dto.dart';

class CompetitionsRemoteDataSource {
  final ApiManager _apiManager;
  CompetitionsRemoteDataSource(this._apiManager);

  Future<ApiResponse<List<CompetitionDataApiDto>>> getCompetitions(
      {required String clientKey}) async {
    return await _apiManager.requestListAsync<CompetitionDataApiDto>(
      requestType: RequestType.get,
      endpoint: EndPoints.competitions.val(),
      newBaseUrl: AppConfiguration.radarBaseUrl,
      headers: {
        "sr-client-key": clientKey,
      },
    );
  }
}

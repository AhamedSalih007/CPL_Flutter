import '../../../core/configs/app_configuration.dart';
import '../../../core/utils/api/api_manager/api_manager.dart';
import '../../../core/utils/api/request_type.dart';
import '../../../core/utils/api/response/api_response.dart';
import '../../enums/endpoints.dart';
import '../../models/api/points_table/points_table_api_dto.dart';

class PonitsTableRemoteDataSource {
  final ApiManager _apiManager;
  PonitsTableRemoteDataSource(this._apiManager);

  Future<ApiResponse<PointsTableDataApiDto>> pointsTable(
      {String? competitionId, String? clientKey}) async {
    print(
        "comp${AppConfiguration.radarBaseUrl},${EndPoints.pointsTable.val(data: competitionId)}");
    return _apiManager.requestAsync<PointsTableDataApiDto>(
      requestType: RequestType.get,
      endpoint: EndPoints.pointsTable.val(data: competitionId),
      newBaseUrl: AppConfiguration.radarBaseUrl,
      headers: {
        "sr-client-key": clientKey,
      },
    );
  }
}

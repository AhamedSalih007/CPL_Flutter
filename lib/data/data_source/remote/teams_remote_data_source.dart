import '../../../core/utils/api/api_manager/api_manager.dart';
import '../../../core/utils/api/request_type.dart';
import '../../../core/utils/api/response/api_response.dart';
import '../../../domain/enums/team_type.dart';
import '../../enums/endpoints.dart';
import '../../models/api/teams/teams_api_dto.dart';

class TeamsRemoteDataSource {
  final ApiManager _apiManager;
  TeamsRemoteDataSource(this._apiManager);

  Future<ApiResponse<List<TeamsDataApiDto>>> teams(TeamType teamType) async {
    return _apiManager.requestListAsync<TeamsDataApiDto>(
      requestType: RequestType.get,
      endpoint: EndPoints.teams.val(data: teamType.code),
    );
  }
}

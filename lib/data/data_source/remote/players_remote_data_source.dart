import '../../../core/utils/api/api_manager/api_manager.dart';
import '../../../core/utils/api/request_type.dart';
import '../../../core/utils/api/response/api_response.dart';
import '../../enums/endpoints.dart';
import '../../models/api/players/player_api_dto.dart';

class PlayersRemoteDataSource {
  final ApiManager _apiManager;
  PlayersRemoteDataSource(this._apiManager);

  Future<ApiResponse<List<PlayerDataApiDto>>> players(int teamId) async {
    return _apiManager.requestListAsync<PlayerDataApiDto>(
      requestType: RequestType.get,
      endpoint: EndPoints.players.val(data: teamId),
    );
  }
}

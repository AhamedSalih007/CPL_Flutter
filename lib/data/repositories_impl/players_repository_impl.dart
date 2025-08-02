import '../../core/utils/api/response/api_response.dart';
import '../../domain/models/players/player.dart';
import '../../domain/repositories/players_repository.dart';
import '../data_source/remote/players_remote_data_Source.dart';
import '../models/api/players/player_api_dto.dart';
import '../models/result/data_state.dart';

class PlayersRepoImpl implements PlayerRepository {
  final PlayersRemoteDataSource _playersRemoteDataSource;
  PlayersRepoImpl(this._playersRemoteDataSource);

  @override
  Future<DataState<List<PlayerData>>> players(int teamId) async {
    final newsResponse = await _playersRemoteDataSource.players(teamId);
    switch (newsResponse) {
      case ApiResponseSuccess<List<PlayerDataApiDto>>(
          data: List<PlayerDataApiDto> res
        ):
        return DataStateSuccess(res.map((e) => e.toModel()).toList());
      case ApiResponseError<List<PlayerDataApiDto>>(ex: var ex):
        return DataStateError(ex);
    }
  }
}

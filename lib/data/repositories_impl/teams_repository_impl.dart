import '../../core/utils/api/response/api_response.dart';
import '../../domain/enums/team_type.dart';
import '../../domain/models/teams/teams.dart';
import '../../domain/repositories/teams_repository.dart';
import '../data_source/remote/teams_remote_data_source.dart';
import '../models/api/teams/teams_api_dto.dart';
import '../models/result/data_state.dart';

class TeamsRepositoryImpl implements TeamsRepository {
  final TeamsRemoteDataSource _teamsRemoteDataSource;
  TeamsRepositoryImpl(this._teamsRemoteDataSource);

  @override
  Future<DataState<List<TeamsData>>> teams(TeamType teamType) async {
    final newsResponse = await _teamsRemoteDataSource.teams(teamType);
    switch (newsResponse) {
      case ApiResponseSuccess<List<TeamsDataApiDto>>(
          data: List<TeamsDataApiDto> res
        ):
        return DataStateSuccess(res.map((e) => e.toModel()).toList());
      case ApiResponseError<List<TeamsDataApiDto>>(ex: var ex):
        return DataStateError(ex);
    }
  }
}

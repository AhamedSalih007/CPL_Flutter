part of 'teams_usecases.dart';

@Riverpod(keepAlive: true)
GetTeams getTeamsUseCase(GetTeamsUseCaseRef ref) {
  return GetTeams(ref.watch(teamsRepositoryProvider));
}

class GetTeams extends UseCase<DataState<List<TeamsData>>, TeamType> {
  final TeamsRepository _teamsRepository;
  GetTeams(this._teamsRepository);

  @override
  Future<DataState<List<TeamsData>>> call(TeamType teamType) async {
    return await _teamsRepository.teams(teamType);
  }
}

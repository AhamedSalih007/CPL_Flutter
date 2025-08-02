part of 'teams_usecases.dart';

@Riverpod(keepAlive: true)
GetPlayers getPlayersUseCase(GetPlayersUseCaseRef ref) {
  return GetPlayers(ref.watch(playerRepositoryProvider));
}

class GetPlayers extends UseCase<DataState<List<PlayerData>>, int> {
  final PlayerRepository _playerRepository;
  GetPlayers(this._playerRepository);

  @override
  Future<DataState<List<PlayerData>>> call(int teamId) async {
    return await _playerRepository.players(teamId);
  }
}

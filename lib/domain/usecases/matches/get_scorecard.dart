part of 'matches_usecases.dart';

@Riverpod(keepAlive: true)
GetScoreCard getScoreCardUseCase(GetScoreCardUseCaseRef ref) {
  return GetScoreCard(ref.watch(matchesRepositoryProvider));
}

class GetScoreCard
    extends UseCase<DataState<MatchDetails>, MatchDetailsParams> {
  final MatchesRepository _matchesRepository;
  GetScoreCard(this._matchesRepository);

  @override
  Future<DataState<MatchDetails>> call(MatchDetailsParams params) async {
    return await _matchesRepository.scoreCard(
        matchId: params.matchId,
        cancelToken: CancelToken(),
        clientKey: params.clientKey);
  }
}

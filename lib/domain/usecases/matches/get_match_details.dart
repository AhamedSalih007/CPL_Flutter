part of 'matches_usecases.dart';

@Riverpod(keepAlive: true)
GetMatchDetails getMatchDetailsUseCase(GetMatchDetailsUseCaseRef ref) {
  return GetMatchDetails(ref.watch(matchesRepositoryProvider));
}

class GetMatchDetails
    extends UseCase<DataState<MatchDetails>, MatchDetailsParams> {
  final MatchesRepository _matchesRepository;
  GetMatchDetails(this._matchesRepository);

  @override
  Future<DataState<MatchDetails>> call(MatchDetailsParams params) async {
    return await _matchesRepository.getMatchSummary(
        matchId: params.matchId,
        cancelToken: CancelToken(),
        clientKey: params.clientKey);
  }
}

class MatchDetailsParams {
  String matchId;
  String clientKey;

  MatchDetailsParams({required this.clientKey, required this.matchId});
}

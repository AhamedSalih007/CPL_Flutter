part of 'matches_usecases.dart';

@Riverpod(keepAlive: true)
GetMatches getMatchesUseCase(GetMatchesUseCaseRef ref) {
  return GetMatches(ref.watch(matchesRepositoryProvider));
}

class GetMatches extends UseCase<DataState<List<MatchDetails>>, MatchParams> {
  final MatchesRepository _matchesRepository;
  GetMatches(this._matchesRepository);

  @override
  Future<DataState<List<MatchDetails>>> call(MatchParams matchParams) async {
    return await _matchesRepository.getMatches(
        matchesReqbody: matchParams.matchesReqbody,
        cancelToken: CancelToken(),
        clientKey: matchParams.clientKey);
  }
}

class MatchParams {
  MatchesReqbody matchesReqbody;
  String clientKey;

  MatchParams({required this.clientKey, required this.matchesReqbody});
}

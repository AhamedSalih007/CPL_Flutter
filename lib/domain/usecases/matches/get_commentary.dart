part of 'matches_usecases.dart';

@Riverpod(keepAlive: true)
GetCommentary getCommentaryUseCase(GetCommentaryUseCaseRef ref) {
  return GetCommentary(ref.watch(matchesRepositoryProvider));
}

class GetCommentary extends UseCase<DataState<MatchDetails>, CommentaryParams> {
  final MatchesRepository _matchesRepository;
  GetCommentary(this._matchesRepository);

  @override
  Future<DataState<MatchDetails>> call(CommentaryParams params) async {
    return await _matchesRepository.getCommentary(
        matchId: params.matchId,
        inningsId: params.inningsId,
        cancelToken: CancelToken(),
        clientKey: params.clientKey);
  }
}

class CommentaryParams {
  String matchId;
  String clientKey;
  String inningsId;

  CommentaryParams(
      {required this.clientKey,
      required this.matchId,
      required this.inningsId});
}

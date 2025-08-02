part of 'competitions_usecases.dart';

@Riverpod(keepAlive: true)
GetCompetitions getCompetitionsUseCase(GetCompetitionsUseCaseRef ref) {
  return GetCompetitions(ref.watch(competitionRepositoryProvider));
}

class GetCompetitions
    extends UseCase<DataState<List<CompetitionData>>, String> {
  final CompetitionRepository _competitionRepository;
  GetCompetitions(this._competitionRepository);

  @override
  Future<DataState<List<CompetitionData>>> call(String clientKey) async {
    return await _competitionRepository.competitions(clientKey: clientKey);
  }
}

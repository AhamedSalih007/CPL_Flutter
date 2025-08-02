import '../../core/utils/api/response/api_response.dart';
import '../../domain/models/competitions/competitions.dart';
import '../../domain/repositories/competitions_repository.dart';
import '../data_source/remote/competitions_remote_data_source.dart';
import '../models/api/competitions/competitions_api_dto.dart';
import '../models/result/data_state.dart';

class CompetitionRepoImpl implements CompetitionRepository {
  final CompetitionsRemoteDataSource _competitionsRemoteDataSource;
  CompetitionRepoImpl(this._competitionsRemoteDataSource);

  @override
  Future<DataState<List<CompetitionData>>> competitions(
      {required String clientKey}) async {
    final sponsorsResp = await _competitionsRemoteDataSource.getCompetitions(
        clientKey: clientKey);
    switch (sponsorsResp) {
      case ApiResponseSuccess<List<CompetitionDataApiDto>>(
          data: List<CompetitionDataApiDto> res
        ):
        return DataStateSuccess(res.map((e) => e.toModel()).toList());
      case ApiResponseError<List<CompetitionDataApiDto>>(ex: var ex):
        return DataStateError(ex);
    }
  }
}

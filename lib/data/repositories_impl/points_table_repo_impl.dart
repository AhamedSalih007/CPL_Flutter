import '../../core/utils/api/response/api_response.dart';
import '../../domain/models/points_table/ponits_table.dart';
import '../../domain/repositories/points_table_repository.dart';
import '../data_source/remote/ponits_table_remote_data_source.dart';
import '../models/api/points_table/points_table_api_dto.dart';
import '../models/result/data_state.dart';

class PointsTableRepoImpl implements PointsTableRepository {
  final PonitsTableRemoteDataSource _ponitsTableRemoteDataSource;
  PointsTableRepoImpl(this._ponitsTableRemoteDataSource);

  @override
  Future<DataState<PointsTableData>> pointsTable(
      {String? competitionId, String? clientKey}) async {
    final response = await _ponitsTableRemoteDataSource.pointsTable(
        clientKey: clientKey, competitionId: competitionId);
    switch (response) {
      case ApiResponseSuccess<PointsTableDataApiDto>(
          data: PointsTableDataApiDto res
        ):
        return DataStateSuccess(res.toModel());
      case ApiResponseError<PointsTableDataApiDto>(ex: var ex):
        return DataStateError(ex);
    }
  }
}

part of 'points_table_usecases.dart';

@Riverpod(keepAlive: true)
GetPointsTable getPointsTableUseCase(GetPointsTableUseCaseRef ref) {
  return GetPointsTable(ref.watch(pointsTableRepositoryProvider));
}

class GetPointsTable extends UseCase<DataState<PointsTableData>, PointsParams> {
  final PointsTableRepository _pointsTableRepository;
  GetPointsTable(this._pointsTableRepository);

  @override
  Future<DataState<PointsTableData>> call(PointsParams params) async {
    return await _pointsTableRepository.pointsTable(
        clientKey: params.clientKey, competitionId: params.competitionId);
  }
}

class PointsParams {
  String? competitionId;
  String? clientKey;
  PointsParams({this.clientKey, this.competitionId});
}

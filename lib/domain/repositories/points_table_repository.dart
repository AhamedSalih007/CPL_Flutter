import '../../data/models/result/data_state.dart';
import '../models/points_table/ponits_table.dart';

abstract interface class PointsTableRepository {
  Future<DataState<PointsTableData>> pointsTable(
      {String? competitionId, String? clientKey});
}

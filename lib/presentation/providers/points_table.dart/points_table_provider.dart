import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/configs/app_configuration.dart';
import '../../../data/models/result/data_state.dart';
import '../../../domain/enums/category.dart';
import '../../../domain/models/points_table/ponits_table.dart';
import '../../../domain/states/competitions_state.dart';
import '../../../domain/states/points_table_state.dart';
import '../../../domain/usecases/points_table/points_table_usecases.dart';
import '../competitions/competitions_provider.dart';
import '../home/home_provider.dart';

part 'points_table_provider.g.dart';

@riverpod
class PointsTableNotifier extends _$PointsTableNotifier {
  late final GetPointsTable _getPointsTable =
      ref.watch(getPointsTableUseCaseProvider);

  @override
  PointsTableState build() {
    return const PointsTableStateInitial();
  }

  Future<void> getPointsTable({String? competitionId}) async {
    state = const PointsTableStateLoading();
    var dataState = await _getPointsTable(
      PointsParams(
        competitionId: ref.read(competitionsNotifierProvider).competitionId,
        clientKey:
            ref.watch(selectedCategoryNotifierProvider) == CategoryType.cpl
                ? AppConfiguration.clientKey
                : AppConfiguration.wcplClientKey,
      ),
    );
    switch (dataState) {
      case DataStateSuccess<PointsTableData>(
          data: PointsTableData pointsTableData
        ):
        //sort them according to the ranking
        state = PointsTableStateLoaded(pointsTableData: pointsTableData);

      case DataStateError<PointsTableData>(ex: var ex):
        state = PointsTableStateError(ex: ex);
    }
  }

  List<PointsTableTeams> getSortedTeams() {
    List<PointsTableTeams> teams = [];
    var stateTeams = state.teams();
    if (stateTeams != null && stateTeams.isNotEmpty) {
      for (var team in stateTeams) {
        teams.add(team);
      }
      teams.sort((a, b) => (a.rank ?? 0) - (b.rank ?? 0));
      return teams;
    }
    return [];
  }
}

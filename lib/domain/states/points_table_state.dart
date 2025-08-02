import 'package:flutter/foundation.dart';

import '../../core/utils/errors/app_exception.dart';
import '../models/points_table/ponits_table.dart';

@immutable
sealed class PointsTableState {
  const PointsTableState();
}

final class PointsTableStateInitial extends PointsTableState {
  const PointsTableStateInitial();
}

final class PointsTableStateLoading extends PointsTableState {
  const PointsTableStateLoading();
}

final class PointsTableStateLoaded extends PointsTableState {
  const PointsTableStateLoaded({
    required this.pointsTableData,
  });

  final PointsTableData pointsTableData;
}

final class PointsTableStateError extends PointsTableState {
  const PointsTableStateError({required this.ex});
  final AppException ex;
}

extension PointsTableStateExtention on PointsTableState {
  List<PointsTableTeams>? teams() {
    return switch (this) {
      PointsTableStateInitial() => null,
      PointsTableStateLoaded(pointsTableData: var pointsTableData) =>
        pointsTableData.ladders?.first.teams ?? [],
      PointsTableStateLoading() => null,
      PointsTableStateError(ex: _) => null,
    };
  }
}

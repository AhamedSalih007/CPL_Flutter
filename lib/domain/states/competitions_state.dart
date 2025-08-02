import 'package:flutter/material.dart';

import '../../core/utils/errors/app_exception.dart';
import '../models/competitions/competitions.dart';

@immutable
sealed class CompetitionState {
  const CompetitionState();
}

final class CompetitionStateInitial extends CompetitionState {
  const CompetitionStateInitial();
}

final class CompetitionStateLoading extends CompetitionState {
  const CompetitionStateLoading();
}

final class CompetitionStateLoaded extends CompetitionState {
  const CompetitionStateLoaded({required this.competitionData});
  final List<CompetitionData> competitionData;

  @override
  String toString() => 'CompetitionStateLoaded(matches: $competitionData)';
}

final class CompetitionStateError extends CompetitionState {
  const CompetitionStateError(this.ex);
  final AppException ex;

  @override
  String toString() => 'CompetitionStateError(ex: $ex)';
}

extension CompetitonStateExtension on CompetitionState {
  String? get competitionId => switch (this) {
        CompetitionStateInitial() => null,
        CompetitionStateLoading() => null,
        CompetitionStateLoaded(
          competitionData: List<CompetitionData>? competitionData
        ) =>
          competitionData.isNotEmpty
              ? competitionData.first.competitionId
              : null,
        CompetitionStateError() => null,
      };
}

import 'package:flutter/foundation.dart';

import '../../core/utils/errors/app_exception.dart';
import '../models/match_details/match_details.dart';

@immutable
sealed class MatchDetailState {
  const MatchDetailState();
}

final class MatchDetailStateInitial extends MatchDetailState {
  const MatchDetailStateInitial();
}

final class MatchDetailStateLoading extends MatchDetailState {
  const MatchDetailStateLoading();
}

final class MatchDetailStateLoaded extends MatchDetailState {
  const MatchDetailStateLoaded({required this.matchData});
  final MatchDetails matchData;

  @override
  String toString() => 'MatchDetailStateLoaded(matches: $matchData)';
}

final class MatchDetailStateError extends MatchDetailState {
  const MatchDetailStateError(this.ex);
  final AppException ex;

  @override
  String toString() => 'MatchDetailStateError(ex: $ex)';
}

extension MatchLoadingCheck on MatchDetailState {
  bool get isLoading => switch (this) {
        MatchDetailStateInitial() => true,
        MatchDetailStateLoaded(matchData: var _) => false,
        MatchDetailStateLoading() => true,
        MatchDetailStateError(ex: var _) => false,
      };
  MatchDetails? get matchDetails => switch (this) {
        MatchDetailStateInitial() => null,
        MatchDetailStateLoaded(matchData: var data) => data,
        MatchDetailStateLoading() => null,
        MatchDetailStateError(ex: var _) => null,
      };
}

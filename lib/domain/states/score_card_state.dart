import 'package:flutter/foundation.dart';

import '../../core/utils/errors/app_exception.dart';
import '../models/match_details/match_details.dart';

@immutable
sealed class ScoreCardState {
  const ScoreCardState();
}

final class ScoreCardStateInitial extends ScoreCardState {
  const ScoreCardStateInitial();
}

final class ScoreCardStateLoading extends ScoreCardState {
  const ScoreCardStateLoading();
}

final class ScoreCardStateLoaded extends ScoreCardState {
  const ScoreCardStateLoaded({required this.scoreCard});
  final MatchDetails scoreCard;

  @override
  String toString() => 'ScoreCardStateLoaded(matches: $scoreCard)';
}

final class ScoreCardStateError extends ScoreCardState {
  const ScoreCardStateError(this.ex);
  final AppException ex;

  @override
  String toString() => 'ScoreCardStateError(ex: $ex)';
}

extension MatchLoadingCheck on ScoreCardState {}

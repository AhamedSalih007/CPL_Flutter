import 'package:flutter/material.dart';

import '../../core/utils/errors/app_exception.dart';
import '../models/match_details/match_details.dart';

@immutable
sealed class MatchesState {
  const MatchesState();
}

final class MatchesStateInitial extends MatchesState {
  const MatchesStateInitial();
}

final class MatchesStateLoading extends MatchesState {
  const MatchesStateLoading();
}

final class MatchesStateLoaded extends MatchesState {
  const MatchesStateLoaded(
      {required this.matchData,
      required this.completedMatches,
      required this.upcomingMatches,
      required this.liveMatches});
  final List<MatchDetails> matchData;
  final List<MatchDetails> completedMatches;
  final List<MatchDetails> upcomingMatches;
  final List<MatchDetails> liveMatches;

  @override
  String toString() => 'MatchesStateLoaded(matches: $matchData)';
}

final class MatchesStateError extends MatchesState {
  const MatchesStateError(this.ex);
  final AppException ex;

  @override
  String toString() => 'MatchesStateError(ex: $ex)';
}

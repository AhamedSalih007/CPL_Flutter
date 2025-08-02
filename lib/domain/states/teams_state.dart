import 'package:flutter/foundation.dart';

import '../../core/utils/errors/app_exception.dart';
import '../models/teams/teams.dart';

@immutable
sealed class TeamsState {
  const TeamsState();
}

final class TeamsStateInitial extends TeamsState {
  const TeamsStateInitial();
}

final class TeamsStateLoading extends TeamsState {
  const TeamsStateLoading();
}

final class TeamsStateLoaded extends TeamsState {
  const TeamsStateLoaded({required this.teams});
  final List<TeamsData> teams;
}

final class TeamsStateError extends TeamsState {
  const TeamsStateError({required this.ex});
  final AppException ex;
}

extension TeamsStateExtention on TeamsState {}

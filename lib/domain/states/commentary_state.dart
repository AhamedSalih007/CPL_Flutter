import 'package:flutter/foundation.dart';

import '../../core/utils/errors/app_exception.dart';
import '../models/match_details/match_details.dart';

@immutable
sealed class CommentaryState {
  const CommentaryState();
}

final class CommentaryStateInitial extends CommentaryState {
  const CommentaryStateInitial();
}

final class CommentaryStateLoading extends CommentaryState {
  const CommentaryStateLoading();
}

final class CommentaryStateLoaded extends CommentaryState {
  const CommentaryStateLoaded({required this.commentary});
  final List<List<Balls>> commentary;

  @override
  String toString() => 'CommentaryStateLoaded(matches: $commentary)';
}

final class CommentaryStateError extends CommentaryState {
  const CommentaryStateError(this.ex);
  final AppException? ex;

  @override
  String toString() => 'CommentaryStateError(ex: $ex)';
}

extension MatchLoadingCheck on CommentaryState {}

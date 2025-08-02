import 'package:flutter/material.dart';

import '../../core/utils/errors/app_exception.dart';
import '../models/marquee_text/marquee_text.dart';

@immutable
sealed class MarqueeTextState {
  const MarqueeTextState();
}

final class MarqueeTextStateInitial extends MarqueeTextState {
  const MarqueeTextStateInitial();
}

final class MarqueeTextStateLoading extends MarqueeTextState {
  const MarqueeTextStateLoading();
}

final class MarqueeTextStateLoaded extends MarqueeTextState {
  const MarqueeTextStateLoaded({required this.marqueeText});
  final List<MarqueeText> marqueeText;

  @override
  String toString() => 'MarqueeTextStateLoaded(marquees: $marqueeText)';
}

final class MarqueeTextStateError extends MarqueeTextState {
  const MarqueeTextStateError(this.ex);
  final AppException ex;

  @override
  String toString() => 'MarqueeTextStateError(ex: $ex)';
}

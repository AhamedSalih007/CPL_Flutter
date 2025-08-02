import 'package:flutter/foundation.dart';

import '../../core/utils/errors/app_exception.dart';
import '../models/sponsors/sponsors.dart';

@immutable
sealed class SponsorsState {
  const SponsorsState();
}

final class SponsorsStateInitial extends SponsorsState {
  const SponsorsStateInitial();
}

final class SponsorsStateLoading extends SponsorsState {
  const SponsorsStateLoading();
}

final class SponsorsStateLoaded extends SponsorsState {
  const SponsorsStateLoaded(
      {required this.cplSponsors, required this.wcplSponsors});
  final List<SponsorsData> wcplSponsors;
  final List<SponsorsData> cplSponsors;
}

final class SponsorsStateError extends SponsorsState {
  const SponsorsStateError({required this.ex});
  final AppException ex;
}

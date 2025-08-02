import 'package:flutter/foundation.dart';

import '../../core/utils/errors/app_exception.dart';
import '../models/banner/banner.dart';

@immutable
sealed class BannerState {
  const BannerState();
}

final class BannerStateInitial extends BannerState {
  const BannerStateInitial();
}

final class BannerStateLoading extends BannerState {
  const BannerStateLoading();
}

final class BannerStateLoaded extends BannerState {
  const BannerStateLoaded({required this.teamsBanner});
  final BannerAcf? teamsBanner;
}

final class BannerStateError extends BannerState {
  const BannerStateError({required this.ex});
  final AppException ex;
}

extension BannerStateExtention on BannerState {
  BannerAcf? get banner => switch (this) {
        BannerStateInitial() => null,
        BannerStateLoading() => null,
        BannerStateLoaded(teamsBanner: BannerAcf? banner) => banner,
        BannerStateError() => null
      };
}

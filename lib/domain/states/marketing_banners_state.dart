import 'package:flutter/material.dart';

import '../../core/utils/errors/app_exception.dart';
import '../models/marketing_banner/marketing_banner.dart';

@immutable
sealed class MarketingBannerState {
  const MarketingBannerState();
}

final class MarketingBannerStateInitial extends MarketingBannerState {
  const MarketingBannerStateInitial();
}

final class MarketingBannerStateLoading extends MarketingBannerState {
  const MarketingBannerStateLoading();
}

final class MarketingBannerStateLoaded extends MarketingBannerState {
  const MarketingBannerStateLoaded({required this.banners});
  final List<MarketingBanner> banners;

  @override
  String toString() => 'MarketingBannerStateLoaded(banners: $banners)';
}

final class MarketingBannerStateError extends MarketingBannerState {
  const MarketingBannerStateError(this.ex);
  final AppException ex;

  @override
  String toString() => 'MarketingBannerStateError(ex: $ex)';
}

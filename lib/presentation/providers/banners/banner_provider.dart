import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/models/result/data_state.dart';
import '../../../domain/models/banner/banner.dart';
import '../../../domain/models/marketing_banner/marketing_banner.dart';
import '../../../domain/states/marketing_banners_state.dart';
import '../../../domain/states/banner_state.dart';
import '../../../domain/usecases/banners/banners_usecases.dart';

part 'banner_provider.g.dart';

@riverpod
class MarketingBannerNotifier extends _$MarketingBannerNotifier {
  late final MarketingGetBanners _getBannersUsecase =
      ref.watch(getMarketingBannersUseCaseProvider);
  @override
  MarketingBannerState build() {
    return const MarketingBannerStateInitial();
  }

  Future<void> getMarketingBanners() async {
    state = const MarketingBannerStateLoading();
    var dataState = await _getBannersUsecase.call();
    switch (dataState) {
      case DataStateSuccess<List<MarketingBannerData>>(data: var bannersData):
        if (bannersData.isNotEmpty &&
            bannersData[0].acf != null &&
            bannersData[0].acf?.marketingBanner != null &&
            (bannersData[0].acf?.marketingBanner?.isNotEmpty ?? false)) {
          final sortedBanners = bannersData[0].acf?.marketingBanner?.toList();
          if ((sortedBanners?.length ?? 0) > 1) {
            sortedBanners?.sort(
              (a, b) {
                if (a.bannerOrder != null && b.bannerOrder != null) {
                  return a.bannerOrder!.compareTo(b.bannerOrder!);
                }
                return 0;
              },
            );
          }
          state = MarketingBannerStateLoaded(banners: sortedBanners ?? []);
        }
      case DataStateError<List<MarketingBannerData>>(ex: var ex):
        state = MarketingBannerStateError(ex);
    }
  }
}

@Riverpod(keepAlive: true)
class BannerNotifier extends _$BannerNotifier {
  late final GetBanner _getBanner = ref.watch(getBannerUseCaseProvider);

  @override
  BannerState build(int category) {
    return const BannerStateInitial();
  }

  Future<void> getBanner() async {
    state = const BannerStateLoading();
    var respo = await _getBanner(category);
    switch (respo) {
      case DataStateSuccess<List<BannerAcfData>?>(
          data: List<BannerAcfData>? data
        ):
        state = BannerStateLoaded(
            teamsBanner: data?.first.acf ?? const BannerAcf());
      case DataStateError<List<BannerAcfData>>(ex: var ex):
        state = BannerStateError(ex: ex);
    }
  }
}

part of 'banners_usecases.dart';

@Riverpod(keepAlive: true)
MarketingGetBanners getMarketingBannersUseCase(
    GetMarketingBannersUseCaseRef ref) {
  return MarketingGetBanners(ref.watch(bannersRepositoryProvider));
}

class MarketingGetBanners
    extends NoParamsUseCase<DataState<List<MarketingBannerData>>> {
  final BannersRepository _bannersRepository;
  MarketingGetBanners(this._bannersRepository);

  @override
  Future<DataState<List<MarketingBannerData>>> call() async {
    return await _bannersRepository.getAll(
      CancelToken(),
    );
  }
}

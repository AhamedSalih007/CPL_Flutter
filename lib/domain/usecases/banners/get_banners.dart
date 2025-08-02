part of 'banners_usecases.dart';

@Riverpod(keepAlive: true)
GetBanner getBannerUseCase(GetBannerUseCaseRef ref) {
  return GetBanner(ref.watch(bannersRepositoryProvider));
}

class GetBanner extends UseCase<DataState<List<BannerAcfData>>, int> {
  final BannersRepository _bannersRepository;
  GetBanner(this._bannersRepository);

  @override
  Future<DataState<List<BannerAcfData>>> call(int category) async {
    return await _bannersRepository.getBanner(category);
  }
}

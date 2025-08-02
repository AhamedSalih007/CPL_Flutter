part of 'banners_usecases.dart';

@Riverpod(keepAlive: true)
GetMarqueeText getMarqueeTextUseCase(GetMarqueeTextUseCaseRef ref) {
  return GetMarqueeText(ref.watch(bannersRepositoryProvider));
}

class GetMarqueeText extends NoParamsUseCase<DataState<List<MarqueeTextData>>> {
  final BannersRepository _bannersRepository;
  GetMarqueeText(this._bannersRepository);

  @override
  Future<DataState<List<MarqueeTextData>>> call() async {
    return await _bannersRepository.getMarqueeText(
      CancelToken(),
    );
  }
}

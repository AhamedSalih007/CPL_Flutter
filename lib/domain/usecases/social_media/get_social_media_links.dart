part of 'social_media_usecases.dart';

@Riverpod(keepAlive: true)
GetSocialMediaLinks getSocialMediaLinksUseCase(
    GetSocialMediaLinksUseCaseRef ref) {
  return GetSocialMediaLinks(ref.watch(socialMediaRepositoryProvider));
}

class GetSocialMediaLinks
    extends NoParamsUseCase<DataState<List<SocialMediaData>>> {
  final SocialMediaRepository _socialMediaRepository;
  GetSocialMediaLinks(this._socialMediaRepository);

  @override
  Future<DataState<List<SocialMediaData>>> call() async {
    return await _socialMediaRepository.getSocialLinks(CancelToken());
  }
}

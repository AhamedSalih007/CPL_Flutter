part of 'sponsorship_usecases.dart';

@Riverpod(keepAlive: true)
GetSponsors getSponsorsUseCase(GetSponsorsUseCaseRef ref) {
  return GetSponsors(ref.watch(sponsorshipRepositoryProvider));
}

class GetSponsors extends NoParamsUseCase<DataState<List<SponsorsData>>> {
  final SponsorshipRepository _sponsorshipRepository;
  GetSponsors(this._sponsorshipRepository);

  @override
  Future<DataState<List<SponsorsData>>> call() async {
    return await _sponsorshipRepository.sponsors();
  }
}

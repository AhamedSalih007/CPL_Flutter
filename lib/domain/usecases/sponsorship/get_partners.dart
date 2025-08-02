part of 'sponsorship_usecases.dart';

@Riverpod(keepAlive: true)
GetPartners getPartnersUseCase(GetPartnersUseCaseRef ref) {
  return GetPartners(ref.watch(sponsorshipRepositoryProvider));
}

class GetPartners extends NoParamsUseCase<DataState<List<PartnersData>>> {
  final SponsorshipRepository _sponsorshipRepository;
  GetPartners(this._sponsorshipRepository);

  @override
  Future<DataState<List<PartnersData>>> call() async {
    return await _sponsorshipRepository.partners();
  }
}

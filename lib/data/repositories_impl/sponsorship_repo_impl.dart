import '../../core/utils/api/response/api_response.dart';
import '../../domain/models/partners/partners.dart';
import '../../domain/models/sponsors/sponsors.dart';
import '../../domain/repositories/sponsorships_repository.dart';
import '../data_source/remote/sponsorship_remote_data_source.dart';
import '../models/api/partners/partners_api_dto.dart';
import '../models/api/sponsors/sponsers_api_dto.dart';
import '../models/result/data_state.dart';

class SponsorshipRepoImpl implements SponsorshipRepository {
  final SponsorshipRemoteDataSource _sponsorshipRemoteDataSource;
  SponsorshipRepoImpl(this._sponsorshipRemoteDataSource);

  @override
  Future<DataState<List<SponsorsData>>> sponsors() async {
    final sponsorsResp = await _sponsorshipRemoteDataSource.sponsors();
    switch (sponsorsResp) {
      case ApiResponseSuccess<List<SponsorsDataApiDto>>(
          data: List<SponsorsDataApiDto> res
        ):
        return DataStateSuccess(res.map((e) => e.toModel()).toList());
      case ApiResponseError<List<SponsorsDataApiDto>>(ex: var ex):
        return DataStateError(ex);
    }
  }

  @override
  Future<DataState<List<PartnersData>>> partners() async {
    final partnersResponse = await _sponsorshipRemoteDataSource.partners();
    switch (partnersResponse) {
      case ApiResponseSuccess<List<PartnersDataApiDto>>(
          data: List<PartnersDataApiDto> res
        ):
        return DataStateSuccess(res.map((e) => e.toModel()).toList());
      case ApiResponseError<List<PartnersDataApiDto>>(ex: var ex):
        return DataStateError(ex);
    }
  }
}

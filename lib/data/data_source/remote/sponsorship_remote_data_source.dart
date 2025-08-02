import '../../../core/utils/api/api_manager/api_manager.dart';
import '../../../core/utils/api/request_type.dart';
import '../../../core/utils/api/response/api_response.dart';
import '../../enums/endpoints.dart';
import '../../models/api/partners/partners_api_dto.dart';
import '../../models/api/sponsors/sponsers_api_dto.dart';

class SponsorshipRemoteDataSource {
  final ApiManager _apiManager;
  SponsorshipRemoteDataSource(this._apiManager);

  Future<ApiResponse<List<SponsorsDataApiDto>>> sponsors() async {
    return _apiManager.requestListAsync<SponsorsDataApiDto>(
      requestType: RequestType.get,
      endpoint: EndPoints.sponsors.val(),
    );
  }

  Future<ApiResponse<List<PartnersDataApiDto>>> partners() async {
    return _apiManager.requestListAsync<PartnersDataApiDto>(
      requestType: RequestType.get,
      endpoint: EndPoints.partners.val(),
    );
  }
}

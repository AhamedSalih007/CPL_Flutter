import '../../../core/utils/api/api_manager/api_manager.dart';
import '../../../core/utils/api/request_type.dart';
import '../../../core/utils/api/response/api_response.dart';
import '../../enums/endpoints.dart';
import '../../models/api/social_media/social_media_api_dto.dart';

class SocialMediaRemoteDataSource {
  final ApiManager _apiManager;
  SocialMediaRemoteDataSource(this._apiManager);

  Future<ApiResponse<List<SocialMediaDataApiDto>>> getSocialLinks() async {
    return _apiManager.requestListAsync<SocialMediaDataApiDto>(
      requestType: RequestType.get,
      endpoint: EndPoints.socialMedia.val(),
    );
  }
}

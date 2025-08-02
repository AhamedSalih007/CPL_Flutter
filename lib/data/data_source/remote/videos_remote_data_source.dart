import 'package:dio/dio.dart';

import '../../../core/configs/app_configuration.dart';
import '../../../core/utils/api/api_manager/api_manager.dart';
import '../../../core/utils/api/request_type.dart';
import '../../../core/utils/api/response/api_response.dart';
import '../../enums/endpoints.dart';
import '../../models/api/videos/video_api_dto.dart';
import '../../models/api/yt_video/yt_video_api_dto.dart';

class VideosRemoteDataSource {
  final ApiManager _apiManager;
  VideosRemoteDataSource(this._apiManager);

  Future<ApiResponse<List<VideosApiDto>>> getVideos({
    required String clientKey,
    CancelToken? cancelToken,
  }) async {
    return await _apiManager.requestListAsync<VideosApiDto>(
      requestType: RequestType.get,
      endpoint: EndPoints.videos.val(),
      newBaseUrl: AppConfiguration.baseUrl,
      headers: {
        "sr-client-key": clientKey,
      },
      cancelToken: cancelToken,
    );
  }

  Future<ApiResponse<YtVideoDataApiDto>> getYtVideos({
    String? pageToken,
    CancelToken? cancelToken,
  }) async {
    return await _apiManager.requestAsync<YtVideoDataApiDto>(
        requestType: RequestType.get,
        endpoint: EndPoints.ytVideos.val(),
        newBaseUrl: AppConfiguration.youtubeBaseUrl,
        cancelToken: cancelToken,
        queryParams: {"pageToken": pageToken});
  }
}

import 'package:dio/dio.dart';

import '../../core/utils/api/response/api_response.dart';
import '../../domain/models/videos/videos.dart';
import '../../domain/models/yt_video/yt_video.dart';
import '../../domain/repositories/video_repository.dart';
import '../data_source/remote/videos_remote_data_source.dart';
import '../models/api/videos/video_api_dto.dart';
import '../models/api/yt_video/yt_video_api_dto.dart';
import '../models/result/data_state.dart';

class VideoRepositoryImpl implements VideoRepository {
  final VideosRemoteDataSource _videoRepoSource;
  VideoRepositoryImpl(this._videoRepoSource);

  @override
  Future<DataState<List<Videos>>> getVideos({
    required String clientKey,
    CancelToken? cancelToken,
  }) async {
    final videoResp = await _videoRepoSource.getVideos(
        clientKey: clientKey, cancelToken: cancelToken);
    switch (videoResp) {
      case ApiResponseSuccess<List<VideosApiDto>>(data: List<VideosApiDto> res):
        return DataStateSuccess(res.map((e) => e.toModel()).toList());
      case ApiResponseError<List<VideosApiDto>>(ex: var ex):
        return DataStateError(ex);
    }
  }

  @override
  Future<DataState<YtVideoData>> getYtVideos({
    String? pageToken,
    CancelToken? cancelToken,
  }) async {
    final videoResp = await _videoRepoSource.getYtVideos(
        pageToken: pageToken, cancelToken: cancelToken);
    switch (videoResp) {
      case ApiResponseSuccess<YtVideoDataApiDto>(data: YtVideoDataApiDto res):
        return DataStateSuccess(res.toModel());
      case ApiResponseError<YtVideoDataApiDto>(ex: var ex):
        return DataStateError(ex);
    }
  }
}

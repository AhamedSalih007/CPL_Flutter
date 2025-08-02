import 'package:dio/dio.dart';

import '../../data/models/result/data_state.dart';
import '../models/videos/videos.dart';
import '../models/yt_video/yt_video.dart';

abstract interface class VideoRepository {
  Future<DataState<List<Videos>>> getVideos({
    required String clientKey,
    CancelToken? cancelToken,
  });

  Future<DataState<YtVideoData>> getYtVideos({
    String? pageToken,
    CancelToken? cancelToken,
  });
}

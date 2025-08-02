import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/configs/usecase.dart';
import '../../../data/models/result/data_state.dart';
import '../../models/videos/videos.dart';
import '../../models/yt_video/yt_video.dart';
import '../../repositories/video_repository.dart';
import '../../service_providers.dart';

part 'get_videos.dart';
part 'get_yt_videos.dart';
part 'videos_usecases.g.dart';

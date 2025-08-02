import 'package:dio/dio.dart';

import '../../data/models/result/data_state.dart';
import '../models/social_media/social_media.dart';

abstract interface class SocialMediaRepository {
  Future<DataState<List<SocialMediaData>>> getSocialLinks(
    CancelToken? cancelToken,
  );
}

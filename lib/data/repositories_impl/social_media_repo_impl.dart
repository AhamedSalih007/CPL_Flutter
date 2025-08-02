import 'package:dio/dio.dart';

import '../../core/utils/api/response/api_response.dart';
import '../../domain/models/social_media/social_media.dart';
import '../../domain/repositories/social_media_repository.dart';
import '../data_source/remote/social_media_remote_data_source.dart';
import '../models/api/social_media/social_media_api_dto.dart';
import '../models/result/data_state.dart';

class SocialMediaRepoImpl implements SocialMediaRepository {
  final SocialMediaRemoteDataSource _socialMediaRemoteDataSource;
  SocialMediaRepoImpl(this._socialMediaRemoteDataSource);

  @override
  Future<DataState<List<SocialMediaData>>> getSocialLinks(
      CancelToken? cancelToken) async {
    final newsResponse = await _socialMediaRemoteDataSource.getSocialLinks();
    switch (newsResponse) {
      case ApiResponseSuccess<List<SocialMediaDataApiDto>>(
          data: List<SocialMediaDataApiDto> res
        ):
        return DataStateSuccess(res.map((e) => e.toModel()).toList());
      case ApiResponseError<List<SocialMediaDataApiDto>>(ex: var ex):
        return DataStateError(ex);
    }
  }
}

import 'package:dio/dio.dart';

import '../../core/utils/api/response/api_response.dart';
import '../../domain/models/banner/banner.dart';
import '../../domain/models/marketing_banner/marketing_banner.dart';
import '../../domain/models/marquee_text/marquee_text.dart';
import '../../domain/repositories/banners_repository.dart';
import '../data_source/remote/banners_remote_data_source.dart';
import '../models/api/marketing_banner/marketing_banner_api_dto.dart';
import '../models/api/marquee_text/marquee_text_api_dto.dart';
import '../models/api/banner/banner_api_dto.dart';
import '../models/result/data_state.dart';

class BannersRepositoryImpl implements BannersRepository {
  final BannersRemoteDataSource _bannersRemoteDataSource;
  BannersRepositoryImpl(this._bannersRemoteDataSource);
  @override
  Future<DataState<List<MarketingBannerData>>> getAll(
    CancelToken? cancelToken,
  ) async {
    final bannerResponse =
        await _bannersRemoteDataSource.getBanners(cancelToken);
    switch (bannerResponse) {
      case ApiResponseSuccess<List<MarketingBannerDataApiDto>>(
          data: List<MarketingBannerDataApiDto> res
        ):
        return DataStateSuccess(res.map((e) => e.toModel()).toList());
      case ApiResponseError<List<MarketingBannerDataApiDto>>(ex: var ex):
        return DataStateError(ex);
    }
  }

  @override
  Future<DataState<List<MarqueeTextData>>> getMarqueeText(
    CancelToken? cancelToken,
  ) async {
    final bannerResponse =
        await _bannersRemoteDataSource.getMarqueeTexts(cancelToken);
    switch (bannerResponse) {
      case ApiResponseSuccess<List<MarqueeTextDataApiDto>>(
          data: List<MarqueeTextDataApiDto> res
        ):
        return DataStateSuccess(res.map((e) => e.toModel()).toList());
      case ApiResponseError<List<MarqueeTextDataApiDto>>(ex: var ex):
        return DataStateError(ex);
    }
  }

  @override
  Future<DataState<List<BannerAcfData>>> getBanner(int category) async {
    final newsResponse = await _bannersRemoteDataSource.teamsBanner(category);
    switch (newsResponse) {
      case ApiResponseSuccess<List<BannerAcfDataApiDto>>(
          data: List<BannerAcfDataApiDto> res
        ):
        return DataStateSuccess(res.map((e) => e.toModel()).toList());
      case ApiResponseError<List<BannerAcfDataApiDto>>(ex: var ex):
        return DataStateError(ex);
    }
  }
}

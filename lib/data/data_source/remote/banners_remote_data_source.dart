import 'package:dio/dio.dart';

import '../../../core/utils/api/api_manager/api_manager.dart';
import '../../../core/utils/api/request_type.dart';
import '../../../core/utils/api/response/api_response.dart';
import '../../enums/endpoints.dart';
import '../../models/api/marketing_banner/marketing_banner_api_dto.dart';
import '../../models/api/marquee_text/marquee_text_api_dto.dart';
import '../../models/api/banner/banner_api_dto.dart';

class BannersRemoteDataSource {
  final ApiManager _apiManager;
  BannersRemoteDataSource(this._apiManager);

  Future<ApiResponse<List<MarketingBannerDataApiDto>>> getBanners(
    CancelToken? cancelToken,
  ) async {
    return await _apiManager.requestListAsync<MarketingBannerDataApiDto>(
      requestType: RequestType.get,
      endpoint: EndPoints.marketingBanner.val(),
      cancelToken: cancelToken,
    );
  }

  Future<ApiResponse<List<MarqueeTextDataApiDto>>> getMarqueeTexts(
    CancelToken? cancelToken,
  ) async {
    return await _apiManager.requestListAsync<MarqueeTextDataApiDto>(
      requestType: RequestType.get,
      endpoint: EndPoints.marqueeText.val(),
      cancelToken: cancelToken,
    );
  }

  Future<ApiResponse<List<BannerAcfDataApiDto>>> teamsBanner(
      int category) async {
    return _apiManager.requestListAsync<BannerAcfDataApiDto>(
      requestType: RequestType.get,
      endpoint: EndPoints.banner.val(data: category),
    );
  }
}

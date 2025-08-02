import 'package:dio/dio.dart';

import '../../data/models/result/data_state.dart';
import '../models/banner/banner.dart';
import '../models/marketing_banner/marketing_banner.dart';
import '../models/marquee_text/marquee_text.dart';

abstract interface class BannersRepository {
  Future<DataState<List<MarketingBannerData>>> getAll(
    CancelToken? cancelToken,
  );
  Future<DataState<List<MarqueeTextData>>> getMarqueeText(
    CancelToken? cancelToken,
  );

  Future<DataState<List<BannerAcfData>>> getBanner(int category);
}

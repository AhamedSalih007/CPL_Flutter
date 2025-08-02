import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/configs/usecase.dart';
import '../../../data/models/result/data_state.dart';
import '../../models/banner/banner.dart';
import '../../models/marketing_banner/marketing_banner.dart';
import '../../models/marquee_text/marquee_text.dart';
import '../../repositories/banners_repository.dart';
import '../../service_providers.dart';

part 'get_marquee_text.dart';
part 'banners_usecases.g.dart';
part 'get_marketing_banners.dart';
part 'get_banners.dart';

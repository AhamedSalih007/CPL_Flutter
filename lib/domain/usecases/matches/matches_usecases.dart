import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/configs/usecase.dart';
import '../../../data/models/request_body/matches_req_body.dart';
import '../../../data/models/result/data_state.dart';
import '../../models/match_details/match_details.dart';
import '../../repositories/matches_repository.dart';
import '../../service_providers.dart';

part 'get_matches.dart';
part 'get_match_details.dart';
part 'get_scorecard.dart';
part 'get_commentary.dart';
part 'matches_usecases.g.dart';

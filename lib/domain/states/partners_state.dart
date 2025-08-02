import 'package:flutter/foundation.dart';

import '../../core/utils/errors/app_exception.dart';
import '../models/partners/partners.dart';

@immutable
sealed class PartnersState {
  const PartnersState();
}

final class PartnersStateInitial extends PartnersState {
  const PartnersStateInitial();
}

final class PartnersStateLoading extends PartnersState {
  const PartnersStateLoading();
}

final class PartnersStateLoaded extends PartnersState {
  const PartnersStateLoaded(
      {required this.cplPartners, required this.wcplPartners});
  final List<PartnersData> cplPartners;
  final List<PartnersData> wcplPartners;
}

final class PartnersStateError extends PartnersState {
  const PartnersStateError({required this.ex});
  final AppException ex;
}

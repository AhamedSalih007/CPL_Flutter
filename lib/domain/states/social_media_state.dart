import 'package:flutter/foundation.dart';

import '../../core/utils/errors/app_exception.dart';
import '../models/social_media/social_media.dart';

@immutable
sealed class SocialMediaState {
  const SocialMediaState();
}

final class SocialMediaStateInitial extends SocialMediaState {
  const SocialMediaStateInitial();
}

final class SocialMediaStateLoading extends SocialMediaState {
  const SocialMediaStateLoading();
}

final class SocialMediaStateLoaded extends SocialMediaState {
  const SocialMediaStateLoaded({required this.socialMedia});
  final List<SocialMedia> socialMedia;
}

final class SocialMediaStateError extends SocialMediaState {
  const SocialMediaStateError({required this.ex});
  final AppException ex;
}

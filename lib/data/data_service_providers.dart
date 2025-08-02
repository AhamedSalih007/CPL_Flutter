import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../core/device/connectivity_service.dart';
import '../core/device/notification_service.dart';
import '../core/logger/logger_service.dart';
import '../core/utils/api/api_manager/api_manager.dart';
import '../core/utils/api/api_manager/api_manager_impl.dart';
import '../core/utils/local_storage/cache/cache_manager.dart';
import '../core/utils/local_storage/cache/cache_manager_impl.dart';
import '../core/utils/local_storage/secure/secure_storage_manager.dart';
import '../core/utils/local_storage/secure/secure_storage_manager_impl.dart';
import 'data_source/local/user_local_data_source.dart';
import 'data_source/remote/banners_remote_data_source.dart';
import 'data_source/remote/competitions_remote_data_source.dart';
import 'data_source/remote/matches_remote_data_source.dart';
import 'data_source/remote/news_remote_data_source.dart';
import 'data_source/remote/players_remote_data_Source.dart';
import 'data_source/remote/ponits_table_remote_data_source.dart';
import 'data_source/remote/social_media_remote_data_source.dart';
import 'data_source/remote/sponsorship_remote_data_source.dart';
import 'data_source/remote/teams_remote_data_source.dart';
import 'data_source/remote/user_remote_data_source.dart';
import 'data_source/remote/videos_remote_data_source.dart';

part 'data_service_providers.g.dart';

///?Device Services Providers
@Riverpod(keepAlive: true)
ConnectivityService connectivityService(ConnectivityServiceRef ref) {
  return ConnectivityService();
}

@Riverpod(keepAlive: true)
LoggerService loggerService(LoggerServiceRef ref) {
  return LoggerService();
}

///?Data Source Providers
@Riverpod(keepAlive: true)
SecureStorageManager secureStorageManager(SecureStorageManagerRef ref) {
  return SecureStorageManagerImpl(ref.watch(loggerServiceProvider));
}

@Riverpod(keepAlive: true)
CacheManager cacheManager(CacheManagerRef ref) {
  return CacheManagerImpl(ref.watch(loggerServiceProvider));
}

@Riverpod(keepAlive: true)
ApiManager apiManager(ApiManagerRef ref) {
  return ApiManagerImpl(ref);
}

@Riverpod(keepAlive: true)
NotificationService notificationService(NotificationServiceRef ref) {
  return NotificationService(ref);
}

// ///?Local Data Source Providers

@Riverpod(keepAlive: true)
UserLocalDataSource userLocalDataSource(UserLocalDataSourceRef ref) {
  return UserLocalDataSource(
    ref.watch(secureStorageManagerProvider),
    ref.watch(cacheManagerProvider),
  );
}

///?Remote Data Source Providers

@Riverpod(keepAlive: true)
UserRemoteDataSource userRemoteDataSource(UserRemoteDataSourceRef ref) {
  return UserRemoteDataSource(ref.watch(apiManagerProvider));
}

@Riverpod(keepAlive: true)
NewsRemoteDataSource newsRemoteDataSource(NewsRemoteDataSourceRef ref) {
  return NewsRemoteDataSource(ref.watch(apiManagerProvider));
}

@Riverpod(keepAlive: true)
BannersRemoteDataSource bannersRemoteDataSource(
    BannersRemoteDataSourceRef ref) {
  return BannersRemoteDataSource(ref.watch(apiManagerProvider));
}

@Riverpod(keepAlive: true)
SponsorshipRemoteDataSource sponsorshipRemoteDataSource(
    SponsorshipRemoteDataSourceRef ref) {
  return SponsorshipRemoteDataSource(ref.watch(apiManagerProvider));
}

@Riverpod(keepAlive: true)
MatchesRemoteDataSource matchesRemoteDataSource(
    MatchesRemoteDataSourceRef ref) {
  return MatchesRemoteDataSource(ref.watch(apiManagerProvider));
}

@Riverpod(keepAlive: true)
VideosRemoteDataSource videosRemoteDataSource(VideosRemoteDataSourceRef ref) {
  return VideosRemoteDataSource(ref.watch(apiManagerProvider));
}

@Riverpod(keepAlive: true)
TeamsRemoteDataSource teamsRemoteDataSource(TeamsRemoteDataSourceRef ref) {
  return TeamsRemoteDataSource(ref.watch(apiManagerProvider));
}

@Riverpod(keepAlive: true)
SocialMediaRemoteDataSource socialMediaRemoteDataSource(
    SocialMediaRemoteDataSourceRef ref) {
  return SocialMediaRemoteDataSource(ref.watch(apiManagerProvider));
}

@Riverpod(keepAlive: true)
PlayersRemoteDataSource playersRemoteDataSource(
    PlayersRemoteDataSourceRef ref) {
  return PlayersRemoteDataSource(ref.watch(apiManagerProvider));
}

@Riverpod(keepAlive: true)
CompetitionsRemoteDataSource competitionsRemoteDataSource(
    CompetitionsRemoteDataSourceRef ref) {
  return CompetitionsRemoteDataSource(ref.watch(apiManagerProvider));
}

@Riverpod(keepAlive: true)
PonitsTableRemoteDataSource ponitsTableRemoteDataSource(
    PonitsTableRemoteDataSourceRef ref) {
  return PonitsTableRemoteDataSource(ref.watch(apiManagerProvider));
}

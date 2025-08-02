import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/data_service_providers.dart';
import '../data/repositories_impl/auth_repository_impl.dart';
import '../data/repositories_impl/banners_repository_impl.dart';
import '../data/repositories_impl/competitions_repo_impl.dart';
import '../data/repositories_impl/matches_repository_impl.dart';
import '../data/repositories_impl/news_repository_impl.dart';
import '../data/repositories_impl/players_repository_impl.dart';
import '../data/repositories_impl/points_table_repo_impl.dart';
import '../data/repositories_impl/social_media_repo_impl.dart';
import '../data/repositories_impl/sponsorship_repo_impl.dart';
import '../data/repositories_impl/teams_repository_impl.dart';
import '../data/repositories_impl/user_repository_impl.dart';
import '../data/repositories_impl/video_repository_impl.dart';
import 'repositories/auth_repository.dart';
import 'repositories/banners_repository.dart';
import 'repositories/competitions_repository.dart';
import 'repositories/matches_repository.dart';
import 'repositories/news_repository.dart';
import 'repositories/players_repository.dart';
import 'repositories/points_table_repository.dart';
import 'repositories/social_media_repository.dart';
import 'repositories/sponsorships_repository.dart';
import 'repositories/teams_repository.dart';
import 'repositories/user_repository.dart';
import 'repositories/video_repository.dart';

part 'service_providers.g.dart';

@Riverpod(keepAlive: true)
UserRepository userRepository(UserRepositoryRef ref) {
  return UserRepositoryImpl(ref.watch(userRemoteDataSourceProvider),
      ref.watch(userLocalDataSourceProvider));
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepositoryImpl(ref.watch(userRepositoryProvider));
}

@Riverpod(keepAlive: true)
NewsRepository newsRepository(NewsRepositoryRef ref) {
  return NewsRepositoryImpl(ref.watch(newsRemoteDataSourceProvider));
}

@Riverpod(keepAlive: true)
BannersRepository bannersRepository(BannersRepositoryRef ref) {
  return BannersRepositoryImpl(ref.watch(bannersRemoteDataSourceProvider));
}

@Riverpod(keepAlive: true)
SponsorshipRepository sponsorshipRepository(SponsorshipRepositoryRef ref) {
  return SponsorshipRepoImpl(ref.watch(sponsorshipRemoteDataSourceProvider));
}

@Riverpod(keepAlive: true)
MatchesRepository matchesRepository(MatchesRepositoryRef ref) {
  return MatchesRepositoryImpl(ref.watch(matchesRemoteDataSourceProvider));
}

@Riverpod(keepAlive: true)
VideoRepository videoRepository(VideoRepositoryRef ref) {
  return VideoRepositoryImpl(ref.watch(videosRemoteDataSourceProvider));
}

@Riverpod(keepAlive: true)
TeamsRepository teamsRepository(TeamsRepositoryRef ref) {
  return TeamsRepositoryImpl(ref.watch(teamsRemoteDataSourceProvider));
}

@Riverpod(keepAlive: true)
SocialMediaRepository socialMediaRepository(SocialMediaRepositoryRef ref) {
  return SocialMediaRepoImpl(ref.watch(socialMediaRemoteDataSourceProvider));
}

@Riverpod(keepAlive: true)
PlayerRepository playerRepository(PlayerRepositoryRef ref) {
  return PlayersRepoImpl(ref.watch(playersRemoteDataSourceProvider));
}

@Riverpod(keepAlive: true)
CompetitionRepository competitionRepository(CompetitionRepositoryRef ref) {
  return CompetitionRepoImpl(ref.watch(competitionsRemoteDataSourceProvider));
}

@Riverpod(keepAlive: true)
PointsTableRepository pointsTableRepository(PointsTableRepositoryRef ref) {
  return PointsTableRepoImpl(ref.watch(ponitsTableRemoteDataSourceProvider));
}

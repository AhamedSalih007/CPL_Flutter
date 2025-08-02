import '../../data/models/api/article/article_api_dto.dart';
import '../../data/models/api/competitions/competitions_api_dto.dart';
import '../../data/models/api/marketing_banner/marketing_banner_api_dto.dart';
import '../../data/models/api/marquee_text/marquee_text_api_dto.dart';
import '../../data/models/api/match_details/match_details_api_dto.dart' as md;
import '../../data/models/api/matches/matches_api_dto.dart';
import '../../data/models/api/media/media_api_dto.dart';
import '../../data/models/api/news/news_api_dto.dart';
import '../../data/models/api/news/search_news/search_news_api_dto.dart';
import '../../data/models/api/partners/partners_api_dto.dart';
import '../../data/models/api/players/player_api_dto.dart';
import '../../data/models/api/points_table/points_table_api_dto.dart';
import '../../data/models/api/social_media/social_media_api_dto.dart';
import '../../data/models/api/sponsors/sponsers_api_dto.dart';
import '../../data/models/api/teams/teams_api_dto.dart' as tm;
import '../../data/models/api/banner/banner_api_dto.dart';
import '../../data/models/api/user/user_api_dto.dart';
import '../../data/models/api/videos/video_api_dto.dart' as vm;
import '../../data/models/api/yt_video/yt_video_api_dto.dart';
import '../utils/errors/app_exception.dart';

abstract class AppSerializer {
  static T fromJson<T>(Map<String, dynamic> json) {
    return switch (T) {
      const (UserApiDto) => UserApiDto.fromJson(json) as T,
      const (ArticleResponseApiDto) =>
        ArticleResponseApiDto.fromJson(json) as T,
      const (ArticleApiDto) => ArticleApiDto.fromJson(json) as T,
      const (ArticleSourceApiDto) => ArticleSourceApiDto.fromJson(json) as T,
      const (NewsDataApiDto) => NewsDataApiDto.fromJson(json) as T,
      const (MarketingBannerDataApiDto) =>
        MarketingBannerDataApiDto.fromJson(json) as T,
      const (MarketingBannerApiDto) =>
        MarketingBannerApiDto.fromJson(json) as T,
      const (MarketingBannerAcfApiDto) =>
        MarketingBannerAcfApiDto.fromJson(json) as T,
      const (NewsApiDto) => NewsApiDto.fromJson(json) as T,
      const (GuidApiDto) => GuidApiDto.fromJson(json) as T,
      const (MarqueeTextDataApiDto) =>
        MarqueeTextDataApiDto.fromJson(json) as T,
      const (MarqueeTextAcfApiDto) => MarqueeTextAcfApiDto.fromJson(json) as T,
      const (MarqueeTextApiDto) => MarqueeTextApiDto.fromJson(json) as T,
      const (SponsorsApiDto) => SponsorsApiDto.fromJson(json) as T,
      const (SponsorsDataApiDto) => SponsorsDataApiDto.fromJson(json) as T,
      const (SponsorsAcfApiDto) => SponsorsAcfApiDto.fromJson(json) as T,
      const (PartnersApiDto) => PartnersApiDto.fromJson(json) as T,
      const (PartnersDataApiDto) => PartnersDataApiDto.fromJson(json) as T,
      const (PartnersAcfApiDto) => PartnersAcfApiDto.fromJson(json) as T,
      const (MatchDataApiDto) => MatchDataApiDto.fromJson(json) as T,

      //match details
      const (md.MatchDetailsApiDto) =>
        md.MatchDetailsApiDto.fromJson(json) as T,
      const (md.CompetitionApiDto) => md.CompetitionApiDto.fromJson(json) as T,
      const (md.VenueApiDto) => md.VenueApiDto.fromJson(json) as T,
      const (md.TossApiDto) => md.TossApiDto.fromJson(json) as T,
      const (md.AdditionalDataApiDto) =>
        md.AdditionalDataApiDto.fromJson(json) as T,
      const (md.FeatureFlagsApiDto) =>
        md.FeatureFlagsApiDto.fromJson(json) as T,
      const (md.OfficialsApiDto) => md.OfficialsApiDto.fromJson(json) as T,
      const (md.ProfilePictureApiDto) =>
        md.ProfilePictureApiDto.fromJson(json) as T,
      const (md.OriginalApiDto) => md.OriginalApiDto.fromJson(json) as T,
      const (md.TeamsApiDto) => md.TeamsApiDto.fromJson(json) as T,
      const (md.InningsScoresApiDto) =>
        md.InningsScoresApiDto.fromJson(json) as T,
      const (md.SquadApiDto) => md.SquadApiDto.fromJson(json) as T,
      const (md.ProgressiveScoresApiDto) =>
        md.ProgressiveScoresApiDto.fromJson(json) as T,
      const (md.DlsApiDto) => md.DlsApiDto.fromJson(json) as T,
      const (md.LiveSummaryApiDto) => md.LiveSummaryApiDto.fromJson(json) as T,
      const (md.CurrentBowlerApiDto) =>
        md.CurrentBowlerApiDto.fromJson(json) as T,
      const (md.CurrentBattersApiDto) =>
        md.CurrentBattersApiDto.fromJson(json) as T,
      const (md.DismissalApiDto) => md.DismissalApiDto.fromJson(json) as T,
      const (md.BowlerApiDto) => md.BowlerApiDto.fromJson(json) as T,
      const (md.FieldersApiDto) => md.FieldersApiDto.fromJson(json) as T,
      const (md.CurrentPartnershipApiDto) =>
        md.CurrentPartnershipApiDto.fromJson(json) as T,
      const (md.RecentBallsApiDto) => md.RecentBallsApiDto.fromJson(json) as T,
      const (md.InningsProgressiveScoreApiDto) =>
        md.InningsProgressiveScoreApiDto.fromJson(json) as T,
      const (md.TopPerformersApiDto) =>
        md.TopPerformersApiDto.fromJson(json) as T,
      const (md.PlayerOfMatchApiDto) =>
        md.PlayerOfMatchApiDto.fromJson(json) as T,
      const (md.TeamApiDto) => md.TeamApiDto.fromJson(json) as T,
      const (md.MostRunsApiDto) => md.MostRunsApiDto.fromJson(json) as T,
      const (md.MostWicketsApiDto) => md.MostWicketsApiDto.fromJson(json) as T,
      //Videos
      const (vm.VideosApiDto) => vm.VideosApiDto.fromJson(json) as T,
      const (vm.GuidApiDto) => vm.GuidApiDto.fromJson(json) as T,
      const (vm.AcfApiDto) => vm.AcfApiDto.fromJson(json) as T,

      //Teams
      const (TeamsApiDto) => TeamsApiDto.fromJson(json) as T,
      const (LogoApiDto) => LogoApiDto.fromJson(json) as T,
      const (OriginalApiDto) => OriginalApiDto.fromJson(json) as T,
      const (VenueApiDto) => VenueApiDto.fromJson(json) as T,
      const (CompetitionApiDto) => CompetitionApiDto.fromJson(json) as T,
      const (tm.TeamsDataApiDto) => tm.TeamsDataApiDto.fromJson(json) as T,
      const (tm.TeamsAcfApiDto) => tm.TeamsAcfApiDto.fromJson(json) as T,
      const (tm.AddTeamApiDto) => tm.AddTeamApiDto.fromJson(json) as T,
      const (tm.LogoApiDto) => tm.LogoApiDto.fromJson(json) as T,
      const (tm.SizeApiDto) => tm.SizeApiDto.fromJson(json) as T,
      const (SocialMediaDataApiDto) =>
        SocialMediaDataApiDto.fromJson(json) as T,
      const (SocialMediaAcfApiDto) => SocialMediaAcfApiDto.fromJson(json) as T,
      const (SocialMediaApiDto) => SocialMediaApiDto.fromJson(json) as T,
      const (PlayerDataApiDto) => PlayerDataApiDto.fromJson(json) as T,
      const (PlayerAcfApiDto) => PlayerAcfApiDto.fromJson(json) as T,
      const (PlayerTeamApiDto) => PlayerTeamApiDto.fromJson(json) as T,
      const (CompetitionDataApiDto) =>
        CompetitionDataApiDto.fromJson(json) as T,
      const (VenuesApiDto) => VenuesApiDto.fromJson(json) as T,
      const (CompetitionTeamsApiDto) =>
        CompetitionTeamsApiDto.fromJson(json) as T,
      const (CompetitionLogoApiDto) =>
        CompetitionLogoApiDto.fromJson(json) as T,

      //Teams Banner
      const (BannerAcfApiDto) => BannerAcfApiDto.fromJson(json) as T,
      const (BannerAcfDataApiDto) => BannerAcfDataApiDto.fromJson(json) as T,
      const (BannerImageApiDto) => BannerImageApiDto.fromJson(json) as T,

      //search news
      const (SearchNewsDataApiDto) => SearchNewsDataApiDto.fromJson(json) as T,
      const (EmbeddedApiDto) => EmbeddedApiDto.fromJson(json) as T,
      const (SelfApiDto) => SelfApiDto.fromJson(json) as T,
      const (SearchAcfApiDto) => SearchAcfApiDto.fromJson(json) as T,

      //points table
      const (PointsTableDataApiDto) =>
        PointsTableDataApiDto.fromJson(json) as T,
      const (LaddersApiDto) => LaddersApiDto.fromJson(json) as T,
      const (PointsTableTeamsApiDto) =>
        PointsTableTeamsApiDto.fromJson(json) as T,

      //media
      const (MediaApiDto) => MediaApiDto.fromJson(json) as T,
      const (MediaDetailsApiDto) => MediaDetailsApiDto.fromJson(json) as T,
      const (MediaSizesApiDto) => MediaSizesApiDto.fromJson(json) as T,
      const (MediumApiDto) => MediumApiDto.fromJson(json) as T,
      const (ImageMetaApiDto) => ImageMetaApiDto.fromJson(json) as T,

      //yt videos
      const (YtVideoDataApiDto) => YtVideoDataApiDto.fromJson(json) as T,
      const (PageInfoApiDto) => PageInfoApiDto.fromJson(json) as T,
      const (YtItemsApiDto) => YtItemsApiDto.fromJson(json) as T,
      const (YtIdApiDto) => YtIdApiDto.fromJson(json) as T,
      const (SnippetApiDto) => SnippetApiDto.fromJson(json) as T,
      const (YtThumbNailsApiDto) => YtThumbNailsApiDto.fromJson(json) as T,

      //?Add API DTO hers
      _ => throw const AppExceptionSerializationError(),
    };
  }
}

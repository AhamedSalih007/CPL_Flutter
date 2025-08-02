import '../../core/configs/app_configuration.dart';
import '../../core/utils/app_constants.dart';

enum EndPoints {
  marketingBanner,
  news,
  marqueeText,
  sponsors,
  partners,
  matches,
  matchDetails,
  teams,
  socialMedia,
  players,
  videos,
  competitions,
  banner,
  searchNews,
  pointsTable,
  media,
  scorecard,
  ytVideos,
  commentary,
}

extension EndPointsBuilder on EndPoints {
  String val<T>({T? data}) {
    switch (this) {
      case EndPoints.news:
        return "news?acf_format=standard";
      case EndPoints.marketingBanner:
        return "posts?categories=4&acf_format=standard";
      case EndPoints.marqueeText:
        return "posts?categories=9&acf_format=standard";
      case EndPoints.sponsors:
        return "sponsors?acf_format=standard";
      case EndPoints.videos:
        return "videos?acf_format=standard";
      case EndPoints.partners:
        return "partner?acf_format=standard";
      case EndPoints.matches:
        return "matches";
      case EndPoints.matchDetails:
        return "match/$data";
      case EndPoints.teams:
        return "teams?acf_format=standard&categories=$data";
      case EndPoints.socialMedia:
        return "posts?categories=21&acf_format=standard";
      case EndPoints.players:
        return "players?acf_format=standard&per_page=100&team=$data";
      case EndPoints.competitions:
        return "competitions";
      case EndPoints.banner:
        return "posts?categories=$data&acf_format=standard&_fields=acf";
      case EndPoints.searchNews:
        return "search?subtype=news&_embed&acf_format=standard&search=$data";
      case EndPoints.pointsTable:
        return "competition/$data/ladders";
      case EndPoints.media:
        return "media/$data";
      case EndPoints.scorecard:
        return "match/$data/scorecard";
      case EndPoints.commentary:
        return "match/$data/balls";
      case EndPoints.ytVideos:
        return "search?key=${AppConfiguration.youtubeAppId}&channelId=${AppConstants.ytChannelId}&part=snippet,id&order=date&maxResults=12";
    }
  }
}

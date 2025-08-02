import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(
  name: 'Env',
  path: '.env',
  obfuscate: true,
)
abstract class Env {
  const Env();

  //TODO: Please note this base url should end with "/"
  @EnviedField(varName: 'BASE_URL')
  static final String baseUrl = _Env.baseUrl;

  @EnviedField(varName: 'API_KEY')
  static final String apiKey = _Env.apiKey;

  @EnviedField(varName: 'RADAR_BASE_URL')
  static final String radarBaseUrl = _Env.radarBaseUrl;

  @EnviedField(varName: 'CLIENT_KEY')
  static final String clientKey = _Env.clientKey;

  @EnviedField(varName: 'WCPL_CLIENT_KEY')
  static final String wcplClientKey = _Env.wcplClientKey;

  @EnviedField(varName: 'ONESIGNAL_APP_ID')
  static final String onesignalAppId = _Env.onesignalAppId;

  @EnviedField(varName: 'YOUTUBE_APP_ID')
  static final String youtubeAppId = _Env.youtubeAppId;

  @EnviedField(varName: 'YOUTUBE_BASE_URL')
  static final String youtubeBaseUrl = _Env.youtubeBaseUrl;
}

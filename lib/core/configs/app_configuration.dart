import '../env/env.dart';

abstract class AppConfiguration {
  static String baseUrl = Env.baseUrl;
  static String radarBaseUrl = Env.radarBaseUrl;
  static String apiKey = Env.apiKey;
  static String clientKey = Env.clientKey;
  static String onesignalAppId = Env.onesignalAppId;
  static String wcplClientKey = Env.wcplClientKey;
  static String youtubeAppId = Env.youtubeAppId;
  static String youtubeBaseUrl = Env.youtubeBaseUrl;
}

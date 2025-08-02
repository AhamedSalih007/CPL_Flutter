import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/utils/mappers/api_dto.dart';
import '../../../../domain/models/yt_video/yt_video.dart';
import '../match_details/match_details_api_dto.dart';

part 'yt_video_api_dto.freezed.dart';
part 'yt_video_api_dto.g.dart';

@freezed
class YtVideoDataApiDto
    with _$YtVideoDataApiDto
    implements ApiDto<YtVideoData> {
  const factory YtVideoDataApiDto({
    String? kind,
    String? etag,
    String? nextPageToken,
    String? regionCode,
    PageInfoApiDto? pageInfo,
    List<YtItemsApiDto>? items,
  }) = _YtVideoDataApiDto;
  const YtVideoDataApiDto._();

  factory YtVideoDataApiDto.fromJson(Map<String, dynamic> json) =>
      _$YtVideoDataApiDtoFromJson(json);

  @override
  YtVideoData toModel() => YtVideoData(
      etag: etag,
      items: items?.map((e) => e.toModel()).toList(),
      kind: kind,
      nextPageToken: nextPageToken,
      pageInfo: pageInfo?.toModel(),
      regionCode: regionCode);
}

@freezed
class PageInfoApiDto with _$PageInfoApiDto implements ApiDto<PageInfo> {
  const factory PageInfoApiDto({
    int? totalResults,
    int? resultsPerPage,
  }) = _PageInfoApiDto;
  const PageInfoApiDto._();

  factory PageInfoApiDto.fromJson(Map<String, dynamic> json) =>
      _$PageInfoApiDtoFromJson(json);

  @override
  PageInfo toModel() => PageInfo(
        resultsPerPage: resultsPerPage,
        totalResults: totalResults,
      );
}

@freezed
class YtItemsApiDto with _$YtItemsApiDto implements ApiDto<YtItems> {
  const factory YtItemsApiDto({
    String? kind,
    String? etag,
    YtIdApiDto? id,
    SnippetApiDto? snippet,
  }) = _YtItemsApiDto;
  const YtItemsApiDto._();

  factory YtItemsApiDto.fromJson(Map<String, dynamic> json) =>
      _$YtItemsApiDtoFromJson(json);

  @override
  YtItems toModel() => YtItems(
        etag: etag,
        id: id?.toModel(),
        kind: kind,
        snippet: snippet?.toModel(),
      );
}

@freezed
class YtIdApiDto with _$YtIdApiDto implements ApiDto<YtId> {
  const factory YtIdApiDto({
    String? kind,
    String? videoId,
  }) = _YtIdApiDto;
  const YtIdApiDto._();

  factory YtIdApiDto.fromJson(Map<String, dynamic> json) =>
      _$YtIdApiDtoFromJson(json);

  @override
  YtId toModel() => YtId(
        kind: kind,
        videoId: videoId,
      );
}

@freezed
class SnippetApiDto with _$SnippetApiDto implements ApiDto<Snippet> {
  const factory SnippetApiDto({
    String? publishedAt,
    String? channelId,
    String? title,
    String? description,
    YtThumbNailsApiDto? thumbnails,
    String? channelTitle,
    String? liveBroadcastContent,
    String? publishTime,
  }) = _SnippetApiDto;
  const SnippetApiDto._();

  factory SnippetApiDto.fromJson(Map<String, dynamic> json) =>
      _$SnippetApiDtoFromJson(json);

  @override
  Snippet toModel() => Snippet(
        publishedAt: publishedAt,
        channelId: channelId,
        channelTitle: channelTitle,
        thumbnails: thumbnails?.toModel(),
        description: description,
        liveBroadcastContent: liveBroadcastContent,
        publishTime: publishTime,
        title: title,
      );
}

@freezed
class YtThumbNailsApiDto
    with _$YtThumbNailsApiDto
    implements ApiDto<YtThumbNails> {
  const factory YtThumbNailsApiDto({
    @JsonKey(name: "default") OriginalApiDto? ytdefault,
    OriginalApiDto? medium,
    OriginalApiDto? high,
  }) = _YtThumbNailsApiDto;
  const YtThumbNailsApiDto._();

  factory YtThumbNailsApiDto.fromJson(Map<String, dynamic> json) =>
      _$YtThumbNailsApiDtoFromJson(json);

  @override
  YtThumbNails toModel() => YtThumbNails(
      ytdefault: ytdefault?.toModel(),
      high: high?.toModel(),
      medium: medium?.toModel());
}

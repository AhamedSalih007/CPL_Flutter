import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../core/utils/mappers/ui_model.dart';
import '../../../data/models/api/yt_video/yt_video_api_dto.dart';
import '../match_details/match_details.dart';

part 'yt_video.freezed.dart';

@freezed
class YtVideoData with _$YtVideoData implements UIModel<YtVideoDataApiDto> {
  const factory YtVideoData({
    String? kind,
    String? etag,
    String? nextPageToken,
    String? regionCode,
    PageInfo? pageInfo,
    List<YtItems>? items,
  }) = _YtVideoData;
  const YtVideoData._();

  @override
  YtVideoDataApiDto toApiDto() => const YtVideoDataApiDto(
      //required field here
      );
}

@freezed
class PageInfo with _$PageInfo implements UIModel<PageInfoApiDto> {
  const factory PageInfo({
    int? totalResults,
    int? resultsPerPage,
  }) = _PageInfo;
  const PageInfo._();

  @override
  PageInfoApiDto toApiDto() => const PageInfoApiDto(
      //required field here
      );
}

@freezed
class YtItems with _$YtItems implements UIModel<YtItemsApiDto> {
  const factory YtItems({
    String? kind,
    String? etag,
    YtId? id,
    Snippet? snippet,
  }) = _YtItems;
  const YtItems._();

  @override
  YtItemsApiDto toApiDto() => const YtItemsApiDto(
      //required field here
      );
}

@freezed
class YtId with _$YtId implements UIModel<YtIdApiDto> {
  const factory YtId({
    String? kind,
    String? videoId,
  }) = _YtId;
  const YtId._();

  @override
  YtIdApiDto toApiDto() => const YtIdApiDto(
      //required field here
      );
}

@freezed
class Snippet with _$Snippet implements UIModel<SnippetApiDto> {
  const factory Snippet({
    String? publishedAt,
    String? channelId,
    String? title,
    String? description,
    YtThumbNails? thumbnails,
    String? channelTitle,
    String? liveBroadcastContent,
    String? publishTime,
  }) = _Snippet;
  const Snippet._();

  @override
  SnippetApiDto toApiDto() => const SnippetApiDto(
      //required field here
      );
}

@freezed
class YtThumbNails with _$YtThumbNails implements UIModel<YtThumbNailsApiDto> {
  const factory YtThumbNails({
    Original? ytdefault,
    Original? medium,
    Original? high,
  }) = _YtThumbNails;
  const YtThumbNails._();

  @override
  YtThumbNailsApiDto toApiDto() => const YtThumbNailsApiDto(
      //required field here
      );
}

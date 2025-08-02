import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/utils/mappers/api_dto.dart';
import '../../../../domain/models/videos/videos.dart';

part 'video_api_dto.freezed.dart';
part 'video_api_dto.g.dart';

@freezed
class VideosApiDto with _$VideosApiDto implements ApiDto<Videos> {
  const factory VideosApiDto({
    @JsonKey(name: "id") final int? id,
    @JsonKey(name: "date") final String? date,
    @JsonKey(name: "date_gmt") final String? dateGmt,
    @JsonKey(name: "guid") final GuidApiDto? guid,
    @JsonKey(name: "modified") final String? modified,
    @JsonKey(name: "modified_gmt") final String? modifiedGmt,
    @JsonKey(name: "slug") final String? slug,
    @JsonKey(name: "status") final String? status,
    @JsonKey(name: "type") final String? type,
    @JsonKey(name: "link") final String? link,
    @JsonKey(name: "title") final GuidApiDto? title,
    @JsonKey(name: "template") final String? template,
    @JsonKey(name: "acf") final AcfApiDto? acf,
  }) = _VideosApiDto;
  const VideosApiDto._();

  factory VideosApiDto.fromJson(Map<String, dynamic> json) =>
      _$VideosApiDtoFromJson(json);

  @override
  Videos toModel() => Videos(
        id: id,
        date: date,
        dateGmt: dateGmt,
        guid: guid?.toModel(),
        modified: modified,
        modifiedGmt: modifiedGmt,
        slug: slug,
        status: status,
        type: type,
        link: link,
        title: title?.toModel(),
        template: template,
        acf: acf?.toModel(),
      );
}

@freezed
class GuidApiDto with _$GuidApiDto implements ApiDto<Guid> {
  const factory GuidApiDto({
    @JsonKey(name: "rendered") final String? rendered,
  }) = _GuidApiDto;
  const GuidApiDto._();

  factory GuidApiDto.fromJson(Map<String, dynamic> json) =>
      _$GuidApiDtoFromJson(json);

  @override
  Guid toModel() => Guid(
        rendered: rendered,
      );
}

@freezed
class AcfApiDto with _$AcfApiDto implements ApiDto<Acf> {
  const factory AcfApiDto({
    @JsonKey(name: "video_title") final String? videoTitle,
    @JsonKey(name: "video_source") final String? videoSource,
    @JsonKey(name: "video_duration") final String? videoDuration,
  }) = _AcfApiDto;
  const AcfApiDto._();

  factory AcfApiDto.fromJson(Map<String, dynamic> json) =>
      _$AcfApiDtoFromJson(json);

  @override
  Acf toModel() => Acf(
        videoTitle: videoTitle,
        videoSource: videoSource,
        videoDuration: videoDuration,
      );
}

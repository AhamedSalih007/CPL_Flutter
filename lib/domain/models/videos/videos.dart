import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/mappers/ui_model.dart';
import '../../../data/models/api/videos/video_api_dto.dart';

part 'videos.freezed.dart';

@freezed
class Videos with _$Videos implements UIModel<VideosApiDto> {
  const factory Videos({
    final int? id,
    final String? date,
    final String? dateGmt,
    final Guid? guid,
    final String? modified,
    final String? modifiedGmt,
    final String? slug,
    final String? status,
    final String? type,
    final String? link,
    final Guid? title,
    final String? template,
    final Acf? acf,
  }) = _Videos;
  const Videos._();

  @override
  VideosApiDto toApiDto() => VideosApiDto(
        id: id,
        date: date,
        dateGmt: dateGmt,
        guid: guid?.toApiDto(),
        modified: modified,
        modifiedGmt: modifiedGmt,
        slug: slug,
        status: status,
        type: type,
        link: link,
        title: title?.toApiDto(),
        template: template,
        acf: acf?.toApiDto(),
      );
}

@freezed
class Guid with _$Guid implements UIModel<GuidApiDto> {
  const factory Guid({
    final String? rendered,
  }) = _Guid;
  const Guid._();

  @override
  GuidApiDto toApiDto() => GuidApiDto(
        rendered: rendered,
      );
}

@freezed
class Acf with _$Acf implements UIModel<AcfApiDto> {
  const factory Acf({
    final String? videoTitle,
    final String? videoSource,
    final String? videoDuration,
  }) = _Acf;
  const Acf._();

  @override
  AcfApiDto toApiDto() => AcfApiDto(
        videoTitle: videoTitle,
        videoSource: videoSource,
        videoDuration: videoDuration,
      );
}

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../core/utils/mappers/ui_model.dart';
import '../../../data/models/api/media/media_api_dto.dart';

part 'media.freezed.dart';

@freezed
class Media with _$Media implements UIModel<MediaApiDto> {
  const factory Media(
      {int? id,
      @JsonKey(name: "media_details") MediaDetails? mediaDetails,
      String? sourceUrl}) = _Media;
  const Media._();

  @override
  MediaApiDto toApiDto() => const MediaApiDto(
      //required field here
      );
}

@freezed
class MediaDetails with _$MediaDetails implements UIModel<MediaDetailsApiDto> {
  const factory MediaDetails({
    int? width,
    int? height,
    String? file,
    int? filesize,
    MediaSizes? sizes,
    ImageMeta? imageMeta,
  }) = _MediaDetails;
  const MediaDetails._();

  @override
  MediaDetailsApiDto toApiDto() => const MediaDetailsApiDto(
      //required field here
      );
}

@freezed
class MediaSizes with _$MediaSizes implements UIModel<MediaSizesApiDto> {
  const factory MediaSizes({
    Medium? medium,
    Medium? large,
    Medium? thumbnail,
    Medium? mediumLarge,
    Medium? full,
  }) = _MediaSizes;
  const MediaSizes._();

  @override
  MediaSizesApiDto toApiDto() => const MediaSizesApiDto(
      //required field here
      );
}

@freezed
class Medium with _$Medium implements UIModel<MediumApiDto> {
  const factory Medium({
    String? file,
    int? width,
    int? height,
    int? filesize,
    String? mimeType,
    String? sourceUrl,
  }) = _Medium;
  const Medium._();

  @override
  MediumApiDto toApiDto() => const MediumApiDto(
      //required field here
      );
}

@freezed
class ImageMeta with _$ImageMeta implements UIModel<ImageMetaApiDto> {
  const factory ImageMeta({
    String? aperture,
    String? credit,
    String? camera,
    String? caption,
    String? createdTimestamp,
    String? copyright,
    String? focalLength,
    String? iso,
    String? shutterSpeed,
    String? title,
    String? orientation,
  }) = _ImageMeta;
  const ImageMeta._();

  @override
  ImageMetaApiDto toApiDto() => const ImageMetaApiDto(
      //required field here
      );
}

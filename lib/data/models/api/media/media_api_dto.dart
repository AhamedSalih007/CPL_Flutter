import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/utils/mappers/api_dto.dart';
import '../../../../domain/models/media/media.dart';

part 'media_api_dto.freezed.dart';
part 'media_api_dto.g.dart';

@freezed
class MediaApiDto with _$MediaApiDto implements ApiDto<Media> {
  const factory MediaApiDto({
    int? id,
    @JsonKey(name: "media_details") MediaDetailsApiDto? mediaDetails,
    @JsonKey(name: "source_url") String? sourceUrl,
  }) = _MediaApiDto;
  const MediaApiDto._();

  factory MediaApiDto.fromJson(Map<String, dynamic> json) =>
      _$MediaApiDtoFromJson(json);

  @override
  Media toModel() => Media(
        id: id,
        mediaDetails: mediaDetails?.toModel(),
        sourceUrl: sourceUrl,
      );
}

@freezed
class MediaDetailsApiDto
    with _$MediaDetailsApiDto
    implements ApiDto<MediaDetails> {
  const factory MediaDetailsApiDto({
    int? width,
    int? height,
    String? file,
    int? filesize,
    MediaSizesApiDto? sizes,
    @JsonKey(name: "image_meta") ImageMetaApiDto? imageMeta,
  }) = _MediaDetailsApiDto;
  const MediaDetailsApiDto._();

  factory MediaDetailsApiDto.fromJson(Map<String, dynamic> json) =>
      _$MediaDetailsApiDtoFromJson(json);

  @override
  MediaDetails toModel() => MediaDetails(
        file: file,
        filesize: filesize,
        height: height,
        imageMeta: imageMeta?.toModel(),
        sizes: sizes?.toModel(),
        width: width,
      );
}

@freezed
class MediaSizesApiDto with _$MediaSizesApiDto implements ApiDto<MediaSizes> {
  const factory MediaSizesApiDto({
    MediumApiDto? medium,
    MediumApiDto? large,
    MediumApiDto? thumbnail,
    @JsonKey(name: "medium_large") MediumApiDto? mediumLarge,
    MediumApiDto? full,
  }) = _MediaSizesApiDto;
  const MediaSizesApiDto._();

  factory MediaSizesApiDto.fromJson(Map<String, dynamic> json) =>
      _$MediaSizesApiDtoFromJson(json);

  @override
  MediaSizes toModel() => MediaSizes(
        medium: medium?.toModel(),
        full: full?.toModel(),
        large: large?.toModel(),
        mediumLarge: mediumLarge?.toModel(),
        thumbnail: thumbnail?.toModel(),
      );
}

@freezed
class MediumApiDto with _$MediumApiDto implements ApiDto<Medium> {
  const factory MediumApiDto({
    String? file,
    int? width,
    int? height,
    int? filesize,
    @JsonKey(name: "mime_type") String? mimeType,
    @JsonKey(name: "source_url") String? sourceUrl,
  }) = _MediumApiDto;
  const MediumApiDto._();

  factory MediumApiDto.fromJson(Map<String, dynamic> json) =>
      _$MediumApiDtoFromJson(json);

  @override
  Medium toModel() => Medium(
        file: file,
        filesize: filesize,
        height: height,
        mimeType: mimeType,
        sourceUrl: sourceUrl,
        width: width,
      );
}

@freezed
class ImageMetaApiDto with _$ImageMetaApiDto implements ApiDto<ImageMeta> {
  const factory ImageMetaApiDto({
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
  }) = _ImageMetaApiDto;
  const ImageMetaApiDto._();

  factory ImageMetaApiDto.fromJson(Map<String, dynamic> json) =>
      _$ImageMetaApiDtoFromJson(json);

  @override
  ImageMeta toModel() => ImageMeta(
      aperture: aperture,
      camera: camera,
      caption: caption,
      copyright: copyright,
      createdTimestamp: createdTimestamp,
      credit: credit,
      focalLength: focalLength,
      iso: iso,
      orientation: orientation,
      shutterSpeed: shutterSpeed,
      title: title);
}

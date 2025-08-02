import 'package:freezed_annotation/freezed_annotation.dart';
import '../teams/teams.dart';
import '../../../core/utils/mappers/ui_model.dart';
import '../../../data/models/api/banner/banner_api_dto.dart';

part 'banner.freezed.dart';

@freezed
class BannerAcfData
    with _$BannerAcfData
    implements UIModel<BannerAcfDataApiDto> {
  const factory BannerAcfData({
    BannerAcf? acf,
  }) = _BannerAcfData;
  const BannerAcfData._();

  @override
  BannerAcfDataApiDto toApiDto() => const BannerAcfDataApiDto(
      //required field here
      );
}

@freezed
class BannerAcf with _$BannerAcf implements UIModel<BannerAcfApiDto> {
  const factory BannerAcf({
    BannerImage? teamsBannerImage,
    BannerImage? matchesBannerImage,
    BannerImage? newsBannerImage,
  }) = _BannerAcf;
  const BannerAcf._();

  @override
  BannerAcfApiDto toApiDto() => const BannerAcfApiDto(
      //required field here
      );
}

@freezed
class BannerImage with _$BannerImage implements UIModel<BannerImageApiDto> {
  const factory BannerImage({
    int? iD,
    int? id,
    String? title,
    String? filename,
    int? filesize,
    String? url,
    String? link,
    String? alt,
    String? author,
    String? description,
    String? caption,
    String? name,
    String? status,
    int? uploadedTo,
    String? date,
    String? modified,
    int? menuOrder,
    String? mimeType,
    String? type,
    String? subtype,
    String? icon,
    int? width,
    int? height,
    Size? sizes,
  }) = _BannerImage;
  const BannerImage._();

  @override
  BannerImageApiDto toApiDto() => const BannerImageApiDto(
      //required field here
      );
}

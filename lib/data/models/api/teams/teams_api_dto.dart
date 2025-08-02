import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/utils/mappers/api_dto.dart';
import '../../../../domain/models/teams/teams.dart';
import '../news/news_api_dto.dart';

part 'teams_api_dto.freezed.dart';
part 'teams_api_dto.g.dart';

@freezed
class TeamsDataApiDto with _$TeamsDataApiDto implements ApiDto<TeamsData> {
  const factory TeamsDataApiDto({
    int? id,
    String? date,
    @JsonKey(name: "date_gmt") String? dateGmt,
    GuidApiDto? guid,
    String? modified,
    String? modifiedGmt,
    String? slug,
    String? status,
    String? type,
    String? link,
    GuidApiDto? title,
    String? template,
    //List<Null>? categories,
    @JsonKey(name: "acf") TeamsAcfApiDto? acf,
    //Links? lLinks,
  }) = _TeamsDataApiDto;
  const TeamsDataApiDto._();

  factory TeamsDataApiDto.fromJson(Map<String, dynamic> json) =>
      _$TeamsDataApiDtoFromJson(json);

  @override
  TeamsData toModel() => TeamsData(
        id: id,
        date: date,
        dateGmt: dateGmt,
        slug: slug,
        title: title?.toModel(),
        acf: acf?.toModel(),
      );
}

@freezed
class TeamsAcfApiDto with _$TeamsAcfApiDto implements ApiDto<TeamsAcf> {
  const factory TeamsAcfApiDto({
    dynamic logo,
    String? wins,
  }) = _TeamsAcfApiDto;
  const TeamsAcfApiDto._();

  factory TeamsAcfApiDto.fromJson(Map<String, dynamic> json) =>
      _$TeamsAcfApiDtoFromJson(json);

  @override
  TeamsAcf toModel() => TeamsAcf(logo: logo, wins: wins);
}

@freezed
class LogoApiDto with _$LogoApiDto implements ApiDto<Logo> {
  const factory LogoApiDto({
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
    SizeApiDto? sizes,
  }) = _LogoApiDto;
  const LogoApiDto._();

  factory LogoApiDto.fromJson(Map<String, dynamic> json) =>
      _$LogoApiDtoFromJson(json);

  @override
  Logo toModel() => Logo(
        iD: iD,
        id: id,
        title: title,
        filename: filename,
        filesize: filesize,
        url: url,
        link: link,
        alt: alt,
        author: author,
        description: description,
        caption: caption,
        name: name,
        status: status,
        uploadedTo: uploadedTo,
        date: date,
        modified: modified,
        menuOrder: menuOrder,
        mimeType: mimeType,
        type: type,
        subtype: subtype,
        icon: icon,
        width: width,
        height: height,
        sizes: sizes?.toModel(),
      );
}

@freezed
class SizeApiDto with _$SizeApiDto implements ApiDto<Size> {
  const factory SizeApiDto({
    @JsonKey(name: "thumbnail") String? thumbnail,
    @JsonKey(name: "thumbnail-width") int? thumbnailWidth,
    @JsonKey(name: "thumbnail-height") int? thumbnailHeight,
    @JsonKey(name: "medium") String? medium,
    @JsonKey(name: "medium-width") int? mediumWidth,
    @JsonKey(name: "medium-height") int? mediumHeight,
    @JsonKey(name: "medium_large") String? mediumLarge,
    @JsonKey(name: "medium_large-width") int? mediumLargeWidth,
    @JsonKey(name: "medium_large-height") int? mediumLargeHeight,
    @JsonKey(name: "large") String? large,
    @JsonKey(name: "large-width") int? largeWidth,
    @JsonKey(name: "large-height") int? largeHeight,
    @JsonKey(name: "1536x1536") String? s1536x1536,
    @JsonKey(name: "1536x1536-width") int? i1536x1536Width,
    @JsonKey(name: "1536x1536-height") int? i1536x1536Height,
    @JsonKey(name: "2048x2048") String? s2048x2048,
    @JsonKey(name: "2048x2048-width") int? i2048x2048Width,
    @JsonKey(name: "2048x2048-height") int? i2048x2048Height,
  }) = _SizeApiDto;
  const SizeApiDto._();

  factory SizeApiDto.fromJson(Map<String, dynamic> json) =>
      _$SizeApiDtoFromJson(json);

  @override
  Size toModel() => Size(
        thumbnail: thumbnail,
        thumbnailWidth: thumbnailHeight,
        thumbnailHeight: thumbnailWidth,
        medium: medium,
        mediumWidth: mediumWidth,
        mediumHeight: mediumHeight,
        mediumLarge: mediumLarge,
        mediumLargeWidth: mediumLargeWidth,
        mediumLargeHeight: mediumLargeHeight,
        large: large,
        largeWidth: largeWidth,
        largeHeight: largeHeight,
        s1536x1536: s1536x1536,
        i1536x1536Width: i1536x1536Width,
        i1536x1536Height: i1536x1536Height,
        s2048x2048: s2048x2048,
        i2048x2048Width: i2048x2048Width,
        i2048x2048Height: i2048x2048Height,
      );
}

@freezed
class AddTeamApiDto with _$AddTeamApiDto implements ApiDto<AddTeam> {
  const factory AddTeamApiDto({
    @JsonKey(name: "team_name") String? teamName,
    @JsonKey(name: "team_logo") String? teamLogo,
    @JsonKey(name: "team_wins") String? teamWins,
  }) = _AddTeamApiDto;
  const AddTeamApiDto._();

  factory AddTeamApiDto.fromJson(Map<String, dynamic> json) =>
      _$AddTeamApiDtoFromJson(json);

  @override
  AddTeam toModel() => AddTeam(
        teamLogo: teamLogo,
        teamName: teamName,
        teamWins: teamWins,
      );
}

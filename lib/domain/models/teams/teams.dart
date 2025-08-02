import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../core/utils/mappers/ui_model.dart';
import '../../../data/models/api/teams/teams_api_dto.dart';
import '../news/news.dart';

part 'teams.freezed.dart';

@freezed
class TeamsData with _$TeamsData implements UIModel<TeamsDataApiDto> {
  const factory TeamsData({
    int? id,
    String? date,
    String? dateGmt,
    Guid? guid,
    String? modified,
    String? modifiedGmt,
    String? slug,
    String? status,
    String? type,
    String? link,
    Guid? title,
    String? template,
    //List<Null>? categories,
    TeamsAcf? acf,
  }) = _TeamsData;
  const TeamsData._();

  @override
  TeamsDataApiDto toApiDto() => const TeamsDataApiDto(
      //required field here
      );
}

@freezed
class TeamsAcf with _$TeamsAcf implements UIModel<TeamsAcfApiDto> {
  const factory TeamsAcf({
    dynamic logo,
    String? wins,
  }) = _TeamsAcf;
  const TeamsAcf._();

  @override
  TeamsAcfApiDto toApiDto() => TeamsAcfApiDto(
        logo: logo?.toApiDto(),
        wins: wins,
      );
}

@freezed
class AddTeam with _$AddTeam implements UIModel<AddTeamApiDto> {
  const factory AddTeam({
    String? teamName,
    String? teamLogo,
    String? teamWins,
  }) = _AddTeam;
  const AddTeam._();

  @override
  AddTeamApiDto toApiDto() => const AddTeamApiDto(
      //required field here
      );
}

@freezed
class Logo with _$Logo implements UIModel<LogoApiDto> {
  const factory Logo({
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
  }) = _Logo;
  const Logo._();

  @override
  LogoApiDto toApiDto() => const LogoApiDto(
      //required field here
      );
}

@freezed
class Size with _$Size implements UIModel<SizeApiDto> {
  const factory Size({
    String? thumbnail,
    int? thumbnailWidth,
    int? thumbnailHeight,
    String? medium,
    int? mediumWidth,
    int? mediumHeight,
    String? mediumLarge,
    int? mediumLargeWidth,
    int? mediumLargeHeight,
    String? large,
    int? largeWidth,
    int? largeHeight,
    String? s1536x1536,
    int? i1536x1536Width,
    int? i1536x1536Height,
    String? s2048x2048,
    int? i2048x2048Width,
    int? i2048x2048Height,
  }) = _Size;
  const Size._();

  @override
  SizeApiDto toApiDto() => const SizeApiDto(
      //required field here
      );
}

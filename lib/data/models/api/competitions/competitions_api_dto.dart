import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/utils/mappers/api_dto.dart';
import '../../../../domain/models/competitions/competitions.dart';
import '../match_details/match_details_api_dto.dart';

part 'competitions_api_dto.freezed.dart';
part 'competitions_api_dto.g.dart';

@freezed
class CompetitionDataApiDto
    with _$CompetitionDataApiDto
    implements ApiDto<CompetitionData> {
  const factory CompetitionDataApiDto({
    String? competitionId,
    String? name,
    List<VenuesApiDto>? venues,
    List<CompetitionTeamsApiDto>? teams,
  }) = _CompetitionDataApiDto;
  const CompetitionDataApiDto._();

  factory CompetitionDataApiDto.fromJson(Map<String, dynamic> json) =>
      _$CompetitionDataApiDtoFromJson(json);

  @override
  CompetitionData toModel() => CompetitionData(
        competitionId: competitionId,
        name: name,
        teams: teams?.map((e) => e.toModel()).toList(),
        venues: venues?.map((e) => e.toModel()).toList(),
      );
}

@freezed
class VenuesApiDto with _$VenuesApiDto implements ApiDto<Venues> {
  const factory VenuesApiDto({
    String? name,
    String? fullName,
    String? venueId,
  }) = _VenuesApiDto;
  const VenuesApiDto._();

  factory VenuesApiDto.fromJson(Map<String, dynamic> json) =>
      _$VenuesApiDtoFromJson(json);

  @override
  Venues toModel() => Venues(
        name: name,
        fullName: fullName,
        venueId: venueId,
      );
}

@freezed
class CompetitionTeamsApiDto
    with _$CompetitionTeamsApiDto
    implements ApiDto<CompetitionTeams> {
  const factory CompetitionTeamsApiDto({
    String? teamId,
    String? name,
    String? shortName,
    CompetitionLogoApiDto? logo,
    String? primaryColour,
    String? secondaryColour,
  }) = _CompetitionTeamsApiDto;
  const CompetitionTeamsApiDto._();

  factory CompetitionTeamsApiDto.fromJson(Map<String, dynamic> json) =>
      _$CompetitionTeamsApiDtoFromJson(json);

  @override
  CompetitionTeams toModel() => CompetitionTeams(
        logo: logo?.toModel(),
        name: name,
        primaryColour: primaryColour,
        secondaryColour: secondaryColour,
        shortName: shortName,
        teamId: teamId,
      );
}

@freezed
class CompetitionLogoApiDto
    with _$CompetitionLogoApiDto
    implements ApiDto<CompetitionLogo> {
  const factory CompetitionLogoApiDto({
    String? name,
    String? alternativeText,
    String? caption,
    OriginalApiDto? original,
    OriginalApiDto? small,
    OriginalApiDto? medium,
  }) = _CompetitionLogoApiDto;
  const CompetitionLogoApiDto._();

  factory CompetitionLogoApiDto.fromJson(Map<String, dynamic> json) =>
      _$CompetitionLogoApiDtoFromJson(json);

  @override
  CompetitionLogo toModel() => CompetitionLogo(
      name: name,
      alternativeText: alternativeText,
      caption: caption,
      medium: medium?.toModel(),
      original: original?.toModel(),
      small: small?.toModel());
}

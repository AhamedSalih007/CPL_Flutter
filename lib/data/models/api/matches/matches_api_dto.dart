import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/utils/mappers/api_dto.dart';
import '../../../../domain/models/match/matches.dart';
import '../match_details/match_details_api_dto.dart';

part 'matches_api_dto.freezed.dart';
part 'matches_api_dto.g.dart';

@freezed
class MatchDataApiDto with _$MatchDataApiDto implements ApiDto<MatchData> {
  const factory MatchDataApiDto({
    String? matchId,
    String? title,
    String? description,
    @JsonKey(name: "class") String? matcheClass,
    String? format,
    String? coverageLevel,
    int? ballsPerOver,
    int? oversPerInnings,
    String? startDate,
    String? endDate,
    int? currentDayNum,
    String? status,
    CompetitionApiDto? competition,
    VenueApiDto? venue,
    List<TeamsApiDto>? teams,
    AdditionalDataApiDto? additionalData,
  }) = _MatchDataApiDto;
  const MatchDataApiDto._();

  factory MatchDataApiDto.fromJson(Map<String, dynamic> json) =>
      _$MatchDataApiDtoFromJson(json);

  @override
  MatchData toModel() => MatchData(
      matchId: matchId,
      title: title,
      description: description,
      matcheClass: matcheClass,
      format: format,
      coverageLevel: coverageLevel,
      ballsPerOver: ballsPerOver,
      oversPerInnings: oversPerInnings,
      startDate: startDate,
      endDate: endDate,
      currentDayNum: currentDayNum,
      status: status,
      competition: competition?.toModel(),
      venue: venue?.toModel(),
      teams: teams?.map((e) => e.toModel()).toList(),
      additionalData: additionalData?.toModel());
}

@freezed
class CompetitionApiDto
    with _$CompetitionApiDto
    implements ApiDto<Competition> {
  const factory CompetitionApiDto({
    String? competitionId,
    String? name,
    String? stageId,
    String? gender,
    int? matchNumber,
  }) = _CompetitionApiDto;
  const CompetitionApiDto._();

  factory CompetitionApiDto.fromJson(Map<String, dynamic> json) =>
      _$CompetitionApiDtoFromJson(json);

  @override
  Competition toModel() => Competition(
      competitionId: competitionId,
      name: name,
      stageId: stageId,
      gender: gender,
      matchNumber: matchNumber);
}

@freezed
class VenueApiDto with _$VenueApiDto implements ApiDto<Venue> {
  const factory VenueApiDto({
    String? name,
    String? fullName,
    String? venueId,
  }) = _VenueApiDto;
  const VenueApiDto._();

  factory VenueApiDto.fromJson(Map<String, dynamic> json) =>
      _$VenueApiDtoFromJson(json);

  @override
  Venue toModel() => Venue(
        name: name,
        fullName: fullName,
        venueId: venueId,
      );
}

@freezed
class TeamsApiDto with _$TeamsApiDto implements ApiDto<Team> {
  const factory TeamsApiDto({
    String? teamId,
    String? name,
    String? shortName,
    LogoApiDto? logo,
    String? primaryColour,
    bool? isHome,
    String? secondaryColour,
  }) = _TeamsApiDto;
  const TeamsApiDto._();

  factory TeamsApiDto.fromJson(Map<String, dynamic> json) =>
      _$TeamsApiDtoFromJson(json);

  @override
  Team toModel() => Team(
      teamId: teamId,
      name: name,
      shortName: shortName,
      logo: logo?.toModel(),
      primaryColour: primaryColour,
      isHome: isHome,
      secondaryColour: secondaryColour);
}

@freezed
class LogoApiDto with _$LogoApiDto implements ApiDto<LogoModel> {
  const factory LogoApiDto({
    String? name,
    String? alternativeText,
    String? caption,
    OriginalApiDto? original,
    OriginalApiDto? small,
    OriginalApiDto? medium,
  }) = _LogoApiDto;
  const LogoApiDto._();

  factory LogoApiDto.fromJson(Map<String, dynamic> json) =>
      _$LogoApiDtoFromJson(json);

  @override
  LogoModel toModel() => LogoModel(
      name: name,
      alternativeText: alternativeText,
      caption: caption,
      original: original?.toModel(),
      small: small?.toModel(),
      medium: medium?.toModel());
}

@freezed
class OriginalApiDto with _$OriginalApiDto implements ApiDto<Original> {
  const factory OriginalApiDto({
    String? url,
    int? width,
    int? height,
  }) = _OriginalApiDto;
  const OriginalApiDto._();

  factory OriginalApiDto.fromJson(Map<String, dynamic> json) =>
      _$OriginalApiDtoFromJson(json);

  @override
  Original toModel() => Original(url: url, width: width, height: height);
}

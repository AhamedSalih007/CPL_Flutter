import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../core/utils/mappers/ui_model.dart';
import '../../../data/models/api/matches/matches_api_dto.dart';
import '../match_details/match_details.dart';

part 'matches.freezed.dart';

@freezed
class MatchData with _$MatchData implements UIModel<MatchDataApiDto> {
  const factory MatchData({
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
    Competition? competition,
    Venue? venue,
    List<Team>? teams,
    AdditionalData? additionalData,
  }) = _MatchData;
  const MatchData._();

  @override
  MatchDataApiDto toApiDto() => const MatchDataApiDto(
      //required field here
      );
}

@freezed
class Competition with _$Competition implements UIModel<CompetitionApiDto> {
  const factory Competition({
    String? competitionId,
    String? name,
    String? stageId,
    String? gender,
    int? matchNumber,
  }) = _Competition;
  const Competition._();

  @override
  CompetitionApiDto toApiDto() => const CompetitionApiDto(
      //required field here
      );
}

@freezed
class Venue with _$Venue implements UIModel<VenueApiDto> {
  const factory Venue({
    String? name,
    String? fullName,
    String? venueId,
  }) = _Venue;
  const Venue._();

  @override
  VenueApiDto toApiDto() => const VenueApiDto(
      //required field here
      );
}

@freezed
class Team with _$Team implements UIModel<TeamsApiDto> {
  const factory Team({
    String? teamId,
    String? name,
    String? shortName,
    LogoModel? logo,
    String? primaryColour,
    bool? isHome,
    String? secondaryColour,
  }) = _Team;
  const Team._();

  @override
  TeamsApiDto toApiDto() => const TeamsApiDto(
      //required field here
      );
}

@freezed
class LogoModel with _$LogoModel implements UIModel<LogoApiDto> {
  const factory LogoModel({
    String? name,
    String? alternativeText,
    String? caption,
    Original? original,
    Original? small,
    Original? medium,
  }) = _LogoModel;
  const LogoModel._();

  @override
  LogoApiDto toApiDto() => const LogoApiDto(
      //required field here
      );
}

@freezed
class Original with _$Original implements UIModel<OriginalApiDto> {
  const factory Original({
    String? url,
    int? width,
    int? height,
  }) = _Original;
  const Original._();

  @override
  OriginalApiDto toApiDto() => const OriginalApiDto(
      //required field here
      );
}

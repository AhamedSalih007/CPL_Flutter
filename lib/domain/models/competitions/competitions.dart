import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../core/utils/mappers/ui_model.dart';
import '../../../data/models/api/competitions/competitions_api_dto.dart';
import '../match_details/match_details.dart';

part 'competitions.freezed.dart';

@freezed
class CompetitionData
    with _$CompetitionData
    implements UIModel<CompetitionDataApiDto> {
  const factory CompetitionData({
    String? competitionId,
    String? name,
    List<Venues>? venues,
    List<CompetitionTeams>? teams,
  }) = _CompetitionData;
  const CompetitionData._();

  @override
  CompetitionDataApiDto toApiDto() => const CompetitionDataApiDto(
      //required field here
      );
}

@freezed
class Venues with _$Venues implements UIModel<VenuesApiDto> {
  const factory Venues({
    String? name,
    String? fullName,
    String? venueId,
  }) = _Venues;
  const Venues._();

  @override
  VenuesApiDto toApiDto() => const VenuesApiDto(
      //required field here
      );
}

@freezed
class CompetitionTeams
    with _$CompetitionTeams
    implements UIModel<CompetitionTeamsApiDto> {
  const factory CompetitionTeams({
    String? teamId,
    String? name,
    String? shortName,
    CompetitionLogo? logo,
    String? primaryColour,
    String? secondaryColour,
  }) = _CompetitionTeams;
  const CompetitionTeams._();

  @override
  CompetitionTeamsApiDto toApiDto() => const CompetitionTeamsApiDto(
      //required field here
      );
}

@freezed
class CompetitionLogo
    with _$CompetitionLogo
    implements UIModel<CompetitionLogoApiDto> {
  const factory CompetitionLogo({
    String? name,
    String? alternativeText,
    String? caption,
    Original? original,
    Original? small,
    Original? medium,
  }) = _CompetitionLogo;
  const CompetitionLogo._();

  @override
  CompetitionLogoApiDto toApiDto() => const CompetitionLogoApiDto(
      //required field here
      );
}

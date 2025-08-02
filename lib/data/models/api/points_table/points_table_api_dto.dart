import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/utils/mappers/api_dto.dart';
import '../../../../domain/models/points_table/ponits_table.dart';
import '../matches/matches_api_dto.dart';

part 'points_table_api_dto.freezed.dart';
part 'points_table_api_dto.g.dart';

@freezed
class PointsTableDataApiDto
    with _$PointsTableDataApiDto
    implements ApiDto<PointsTableData> {
  const factory PointsTableDataApiDto({
    String? competitionId,
    String? name,
    List<LaddersApiDto>? ladders,
  }) = _PointsTableDataApiDto;
  const PointsTableDataApiDto._();

  factory PointsTableDataApiDto.fromJson(Map<String, dynamic> json) =>
      _$PointsTableDataApiDtoFromJson(json);

  @override
  PointsTableData toModel() => PointsTableData(
        competitionId: competitionId,
        ladders: ladders?.map((e) => e.toModel()).toList(),
        name: name,
      );
}

@freezed
class LaddersApiDto with _$LaddersApiDto implements ApiDto<Ladders> {
  const factory LaddersApiDto({
    String? name,
    String? poolId,
    List<PointsTableTeamsApiDto>? teams,
  }) = _LaddersApiDto;
  const LaddersApiDto._();

  factory LaddersApiDto.fromJson(Map<String, dynamic> json) =>
      _$LaddersApiDtoFromJson(json);

  @override
  Ladders toModel() => Ladders(
      name: name,
      poolId: poolId,
      teams: teams?.map((e) => e.toModel()).toList());
}

@freezed
class PointsTableTeamsApiDto
    with _$PointsTableTeamsApiDto
    implements ApiDto<PointsTableTeams> {
  const factory PointsTableTeamsApiDto({
    String? teamId,
    String? name,
    String? shortName,
    LogoApiDto? logo,
    String? primaryColour,
    String? secondaryColour,
    int? rank,
    int? points,
    String? netRunRate,
    int? ties,
    int? losses,
    int? matches,
    int? draws,
    int? abandonments,
    int? wins,
  }) = _PointsTableTeamsApiDto;
  const PointsTableTeamsApiDto._();

  factory PointsTableTeamsApiDto.fromJson(Map<String, dynamic> json) =>
      _$PointsTableTeamsApiDtoFromJson(json);

  @override
  PointsTableTeams toModel() => PointsTableTeams(
        teamId: teamId,
        abandonments: abandonments,
        draws: draws,
        logo: logo?.toModel(),
        losses: losses,
        matches: matches,
        name: name,
        netRunRate: netRunRate,
        points: points,
        primaryColour: primaryColour,
        rank: rank,
        secondaryColour: secondaryColour,
        shortName: shortName,
        ties: ties,
        wins: wins,
      );
}

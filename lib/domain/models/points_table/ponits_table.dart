import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../core/utils/mappers/ui_model.dart';
import '../../../data/models/api/points_table/points_table_api_dto.dart';
import '../match/matches.dart';

part 'ponits_table.freezed.dart';

@freezed
class PointsTableData
    with _$PointsTableData
    implements UIModel<PointsTableDataApiDto> {
  const factory PointsTableData({
    String? competitionId,
    String? name,
    List<Ladders>? ladders,
  }) = _PointsTableData;
  const PointsTableData._();

  @override
  PointsTableDataApiDto toApiDto() => const PointsTableDataApiDto(
      //required field here
      );
}

@freezed
class Ladders with _$Ladders implements UIModel<LaddersApiDto> {
  const factory Ladders({
    String? name,
    String? poolId,
    List<PointsTableTeams>? teams,
  }) = _Ladders;
  const Ladders._();

  @override
  LaddersApiDto toApiDto() => const LaddersApiDto(
      //required field here
      );
}

@freezed
class PointsTableTeams
    with _$PointsTableTeams
    implements UIModel<PointsTableTeamsApiDto> {
  const factory PointsTableTeams({
    String? teamId,
    String? name,
    String? shortName,
    LogoModel? logo,
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
  }) = _PointsTableTeams;
  const PointsTableTeams._();

  @override
  PointsTableTeamsApiDto toApiDto() => const PointsTableTeamsApiDto(
      //required field here
      );
}

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../core/utils/mappers/ui_model.dart';
import '../../../data/models/api/match_graphs/match_graphs_api_dto.dart';
import '../match_details/match_details.dart';

part 'match_graphs.freezed.dart';

@freezed
class MatchGraphDetail
    with _$MatchGraphDetail
    implements UIModel<MatchGraphDetailApiDto> {
  const factory MatchGraphDetail({
    String? matchId,
    String? title,
    String? description,
    String? className,
    String? format,
    String? coverageLevel,
    int? ballsPerOver,
    int? oversPerInnings,
    String? startDate,
    String? endDate,
    int? currentDayNum,
    String? status,
    String? stateOfPlay,
    String? currentInningsId,
    List<Teams>? teams,
    List<Innings>? innings,
    GraphData? graphData,
  }) = _MatchGraphDetail;
  const MatchGraphDetail._();

  @override
  MatchGraphDetailApiDto toApiDto() => const MatchGraphDetailApiDto(
      //required field here
      );
}

@freezed
class GraphData with _$GraphData implements UIModel<GraphDataApiDto> {
  const factory GraphData({
    String? graphType,
    List<Graph>? data,
  }) = _GraphData;
  const GraphData._();

  @override
  GraphDataApiDto toApiDto() => const GraphDataApiDto(
      //required field here
      );
}

@freezed
class Graph with _$Graph implements UIModel<GraphApiDto> {
  const factory Graph({
    int? over,
    InningsData? innings1,
    InningsData? innings2,
    InningsData? innings3,
    InningsData? innings4,
  }) = _Graph;
  const Graph._();

  @override
  GraphApiDto toApiDto() => const GraphApiDto(
      //required field here
      );
}

@freezed
class InningsData with _$InningsData implements UIModel<InningsDataApiDto> {
  const factory InningsData({
    int? run,
    int? wickets,
  }) = _InningsData;
  const InningsData._();

  @override
  InningsDataApiDto toApiDto() => const InningsDataApiDto(
      //required field here
      );
}

@freezed
class Innings with _$Innings implements UIModel<InningsApiDto> {
  const factory Innings({
    String? inningsId,
    String? battingTeamId,
    String? bowlingTeamId,
    int? teamInningsNumber,
    int? matchInningsNumber,
    String? status,
    bool? followingOn,
    bool? isSuperOver,
    String? reasonForClose,
  }) = _Innings;
  const Innings._();

  @override
  InningsApiDto toApiDto() => const InningsApiDto(
      //required field here
      );
}

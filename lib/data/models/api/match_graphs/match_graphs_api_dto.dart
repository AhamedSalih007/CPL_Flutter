import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/utils/mappers/api_dto.dart';
import '../../../../domain/models/match_graphs/match_graphs.dart';
import '../match_details/match_details_api_dto.dart';

part 'match_graphs_api_dto.freezed.dart';
part 'match_graphs_api_dto.g.dart';

@freezed
class MatchGraphDetailApiDto
    with _$MatchGraphDetailApiDto
    implements ApiDto<MatchGraphDetail> {
  const factory MatchGraphDetailApiDto({
    @JsonKey(name: "matchId") String? matchId,
    @JsonKey(name: "title") String? title,
    @JsonKey(name: "description") String? description,
    @JsonKey(name: "class") String? className,
    @JsonKey(name: "format") String? format,
    @JsonKey(name: "coverageLevel") String? coverageLevel,
    @JsonKey(name: "ballsPerOver") int? ballsPerOver,
    @JsonKey(name: "oversPerInnings") int? oversPerInnings,
    @JsonKey(name: "startDate") String? startDate,
    @JsonKey(name: "endDate") String? endDate,
    @JsonKey(name: "currentDayNum") int? currentDayNum,
    @JsonKey(name: "status") String? status,
    @JsonKey(name: "stateOfPlay") String? stateOfPlay,
    @JsonKey(name: "currentInningsId") String? currentInningsId,
    @JsonKey(name: "teams") List<TeamsApiDto>? teams,
    @JsonKey(name: "innings") List<InningsApiDto>? innings,
    @JsonKey(name: "graphData") GraphDataApiDto? graphData,
  }) = _MatchGraphDetailApiDto;
  const MatchGraphDetailApiDto._();

  factory MatchGraphDetailApiDto.fromJson(Map<String, dynamic> json) =>
      _$MatchGraphDetailApiDtoFromJson(json);

  @override
  MatchGraphDetail toModel() => MatchGraphDetail(
      matchId: matchId,
      title: title,
      description: description,
      className: className,
      format: format,
      coverageLevel: coverageLevel,
      ballsPerOver: ballsPerOver,
      oversPerInnings: oversPerInnings,
      startDate: startDate,
      endDate: endDate,
      currentDayNum: currentDayNum,
      status: status,
      stateOfPlay: stateOfPlay,
      currentInningsId: currentInningsId,
      teams: teams?.map((e) => e.toModel()).toList(),
      innings: innings?.map((e) => e.toModel()).toList(),
      graphData: graphData?.toModel());
}

@freezed
class GraphDataApiDto with _$GraphDataApiDto implements ApiDto<GraphData> {
  const factory GraphDataApiDto({
    String? graphType,
    List<GraphApiDto>? data,
  }) = _GraphDataApiDto;
  const GraphDataApiDto._();

  factory GraphDataApiDto.fromJson(Map<String, dynamic> json) =>
      _$GraphDataApiDtoFromJson(json);

  @override
  GraphData toModel() => GraphData(
        data: data?.map((e) => e.toModel()).toList(),
        graphType: graphType,
      );
}

@freezed
class GraphApiDto with _$GraphApiDto implements ApiDto<Graph> {
  const factory GraphApiDto({
    int? over,
    InningsDataApiDto? innings1,
    InningsDataApiDto? innings2,
    InningsDataApiDto? innings3,
    InningsDataApiDto? innings4,
  }) = _GraphApiDto;
  const GraphApiDto._();

  factory GraphApiDto.fromJson(Map<String, dynamic> json) =>
      _$GraphApiDtoFromJson(json);

  @override
  Graph toModel() => Graph(
        over: over,
        innings1: innings1?.toModel(),
        innings2: innings2?.toModel(),
        innings3: innings3?.toModel(),
        innings4: innings4?.toModel(),
      );
}

@freezed
class InningsDataApiDto
    with _$InningsDataApiDto
    implements ApiDto<InningsData> {
  const factory InningsDataApiDto({
    int? run,
    int? wickets,
  }) = _InningsDataApiDto;
  const InningsDataApiDto._();

  factory InningsDataApiDto.fromJson(Map<String, dynamic> json) =>
      _$InningsDataApiDtoFromJson(json);

  @override
  InningsData toModel() => InningsData(
        run: run,
        wickets: wickets,
      );
}

@freezed
class InningsApiDto with _$InningsApiDto implements ApiDto<Innings> {
  const factory InningsApiDto({
    String? inningsId,
    String? battingTeamId,
    String? bowlingTeamId,
    int? teamInningsNumber,
    int? matchInningsNumber,
    String? status,
    bool? followingOn,
    bool? isSuperOver,
    String? reasonForClose,
  }) = _InningsApiDto;
  const InningsApiDto._();

  factory InningsApiDto.fromJson(Map<String, dynamic> json) =>
      _$InningsApiDtoFromJson(json);

  @override
  Innings toModel() => Innings(
        inningsId: inningsId,
        battingTeamId: battingTeamId,
        bowlingTeamId: bowlingTeamId,
        followingOn: followingOn,
        isSuperOver: isSuperOver,
        matchInningsNumber: matchInningsNumber,
        reasonForClose: reasonForClose,
        status: status,
        teamInningsNumber: teamInningsNumber,
      );
}

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/utils/mappers/api_dto.dart';
import '../../../../domain/models/match_details/match_details.dart';

part 'match_details_api_dto.freezed.dart';
part 'match_details_api_dto.g.dart';

@freezed
class MatchDetailsApiDto
    with _$MatchDetailsApiDto
    implements ApiDto<MatchDetails> {
  const factory MatchDetailsApiDto({
    @JsonKey(name: "matchId") final String? matchId,
    @JsonKey(name: "title") final String? title,
    @JsonKey(name: "description") final String? description,
    @JsonKey(name: "class") final String? className,
    @JsonKey(name: "format") final String? format,
    @JsonKey(name: "coverageLevel") final String? coverageLevel,
    @JsonKey(name: "ballsPerOver") final int? ballsPerOver,
    @JsonKey(name: "oversPerInnings") final int? oversPerInnings,
    @JsonKey(name: "startDate") final String? startDate,
    @JsonKey(name: "endDate") final String? endDate,
    @JsonKey(name: "currentDayNum") final int? currentDayNum,
    @JsonKey(name: "status") final String? status,
    @JsonKey(name: "stateOfPlay") final String? stateOfPlay,
    @JsonKey(name: "currentInningsId") final String? currentInningsId,
    @JsonKey(name: "competition") final CompetitionApiDto? competition,
    @JsonKey(name: "venue") final VenueApiDto? venue,
    @JsonKey(name: "toss") final TossApiDto? toss,
    @JsonKey(name: "additionalData") final AdditionalDataApiDto? additionalData,
    @JsonKey(name: "featureFlags") final FeatureFlagsApiDto? featureFlags,
    @JsonKey(name: "officials") final List<OfficialsApiDto>? officials,
    @JsonKey(name: "teams") final List<TeamsApiDto>? teams,
    @JsonKey(name: "inningsScores")
    final List<InningsScoresApiDto>? inningsScores,
    @JsonKey(name: "inningsScorecards")
    final List<InningsScoresApiDto>? inningsScorecards,
    @JsonKey(name: "liveSummary") final LiveSummaryApiDto? liveSummary,
    @JsonKey(name: "topPerformers") final TopPerformersApiDto? topPerformers,
    @JsonKey(name: "inningsBalls") final List<InningsBallsApiDto>? inningsBalls,
  }) = _MatchDetailsApiDto;
  const MatchDetailsApiDto._();

  factory MatchDetailsApiDto.fromJson(Map<String, dynamic> json) =>
      _$MatchDetailsApiDtoFromJson(json);

  @override
  MatchDetails toModel() => MatchDetails(
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
      competition: competition?.toModel(),
      venue: venue?.toModel(),
      toss: toss?.toModel(),
      additionalData: additionalData?.toModel(),
      featureFlags: featureFlags?.toModel(),
      officials: officials?.map((e) => e.toModel()).toList(),
      teams: teams?.map((e) => e.toModel()).toList(),
      inningsScores: inningsScores?.map((e) => e.toModel()).toList(),
      liveSummary: liveSummary?.toModel(),
      topPerformers: topPerformers?.toModel(),
      inningsScorecards: inningsScorecards?.map((e) => e.toModel()).toList(),
      inningsBalls: inningsBalls?.map((e) => e.toModel()).toList(),
      thirdUmpire: (officials != null && officials!.isNotEmpty)
          ? getThirdUmpire(officials!)
          : null,
      fourthUmpire: (officials != null && officials!.isNotEmpty)
          ? getFourthUmpire(officials!)
          : null,
      referee: (officials != null && officials!.isNotEmpty)
          ? getReferee(officials!)
          : null,
      umpires: (officials != null && officials!.isNotEmpty)
          ? getUmpires(officials!)
          : null);

  String getUmpires(List<OfficialsApiDto> officials) {
    var umpires = officials.where((element) => element.matchRole == "Umpire");
    return umpires.map((e) => e.cardNameF).join(" & ");
  }

  String getThirdUmpire(List<OfficialsApiDto> officials) {
    var umpires =
        officials.where((element) => element.matchRole == "Third Umpire");
    return umpires.map((e) => e.cardNameF).join(" & ");
  }

  String getFourthUmpire(List<OfficialsApiDto> officials) {
    var umpires =
        officials.where((element) => element.matchRole == "Fourth Umpire");
    return umpires.map((e) => e.cardNameF).join(" & ");
  }

  String getReferee(List<OfficialsApiDto> officials) {
    var umpires =
        officials.where((element) => element.matchRole == "Match Referee");
    return umpires.map((e) => e.cardNameF).join(" & ");
  }
}

@freezed
class CompetitionApiDto
    with _$CompetitionApiDto
    implements ApiDto<Competition> {
  const factory CompetitionApiDto({
    @JsonKey(name: "competitionId") final String? competitionId,
    @JsonKey(name: "name") final String? name,
    @JsonKey(name: "stageId") final String? stageId,
    @JsonKey(name: "poolId") final String? poolId,
    @JsonKey(name: "matchNumber") final int? matchNumber,
    @JsonKey(name: "gender") final String? gender,
  }) = _CompetitionApiDto;
  const CompetitionApiDto._();

  factory CompetitionApiDto.fromJson(Map<String, dynamic> json) =>
      _$CompetitionApiDtoFromJson(json);

  @override
  Competition toModel() => Competition(
        competitionId: competitionId,
        name: name,
        stageId: stageId,
        poolId: poolId,
        matchNumber: matchNumber,
        gender: gender,
      );
}

@freezed
class VenueApiDto with _$VenueApiDto implements ApiDto<Venue> {
  const factory VenueApiDto({
    @JsonKey(name: "venueId") final String? venueId,
    @JsonKey(name: "name") final String? name,
    @JsonKey(name: "fullName") final String? fullName,
    @JsonKey(name: "knownAs") final String? knownAs,
  }) = _VenueApiDto;
  const VenueApiDto._();

  factory VenueApiDto.fromJson(Map<String, dynamic> json) =>
      _$VenueApiDtoFromJson(json);

  @override
  Venue toModel() => Venue(
        venueId: venueId,
        name: name,
        fullName: fullName,
        knownAs: knownAs,
      );
}

@freezed
class TossApiDto with _$TossApiDto implements ApiDto<Toss> {
  const factory TossApiDto({
    @JsonKey(name: "wonById") final String? wonById,
    @JsonKey(name: "wonByName") final String? wonByName,
    @JsonKey(name: "decision") final String? decision,
  }) = _TossApiDto;
  const TossApiDto._();

  factory TossApiDto.fromJson(Map<String, dynamic> json) =>
      _$TossApiDtoFromJson(json);

  @override
  Toss toModel() => Toss(
        wonById: wonById,
        wonByName: wonByName,
        decision: decision,
      );
}

@freezed
class AdditionalDataApiDto
    with _$AdditionalDataApiDto
    implements ApiDto<AdditionalData> {
  const factory AdditionalDataApiDto({
    @JsonKey(name: "ticketingUrl") final String? ticketingUrl,
    @JsonKey(name: "reportUrl") final String? reportUrl,
    @JsonKey(name: "highlightsUrl") final String? highlightsUrl,
  }) = _AdditionalDataApiDto;
  const AdditionalDataApiDto._();

  factory AdditionalDataApiDto.fromJson(Map<String, dynamic> json) =>
      _$AdditionalDataApiDtoFromJson(json);

  @override
  AdditionalData toModel() => AdditionalData(
        ticketingUrl: ticketingUrl,
        reportUrl: reportUrl,
        highlightsUrl: highlightsUrl,
      );
}

@freezed
class FeatureFlagsApiDto
    with _$FeatureFlagsApiDto
    implements ApiDto<FeatureFlags> {
  const factory FeatureFlagsApiDto({
    @JsonKey(name: "showFielding") final bool? showFielding,
    @JsonKey(name: "showLadder") final bool? showLadder,
  }) = _FeatureFlagsApiDto;
  const FeatureFlagsApiDto._();

  factory FeatureFlagsApiDto.fromJson(Map<String, dynamic> json) =>
      _$FeatureFlagsApiDtoFromJson(json);

  @override
  FeatureFlags toModel() => FeatureFlags(
        showFielding: showFielding,
        showLadder: showLadder,
      );
}

@freezed
class OfficialsApiDto with _$OfficialsApiDto implements ApiDto<Officials> {
  const factory OfficialsApiDto({
    @JsonKey(name: "personId") final String? personId,
    @JsonKey(name: "firstName") final String? firstName,
    @JsonKey(name: "middleName") final String? middleName,
    @JsonKey(name: "lastName") final String? lastName,
    @JsonKey(name: "cardNameF") final String? cardNameF,
    @JsonKey(name: "cardNameS") final String? cardNameS,
    @JsonKey(name: "alphaName") final String? alphaName,
    @JsonKey(name: "profilePicture") final ProfilePictureApiDto? profilePicture,
    @JsonKey(name: "matchRole") final String? matchRole,
  }) = _OfficialsApiDto;
  const OfficialsApiDto._();

  factory OfficialsApiDto.fromJson(Map<String, dynamic> json) =>
      _$OfficialsApiDtoFromJson(json);

  @override
  Officials toModel() => Officials(
        personId: personId,
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        cardNameF: cardNameF,
        cardNameS: cardNameS,
        alphaName: alphaName,
        profilePicture: profilePicture?.toModel(),
        matchRole: matchRole,
      );
}

@freezed
class ProfilePictureApiDto
    with _$ProfilePictureApiDto
    implements ApiDto<ProfilePicture> {
  const factory ProfilePictureApiDto({
    @JsonKey(name: "name") final String? name,
    @JsonKey(name: "alternativeText") final String? alternativeText,
    @JsonKey(name: "caption") final String? caption,
    @JsonKey(name: "original") final OriginalApiDto? original,
    @JsonKey(name: "small") final OriginalApiDto? small,
    @JsonKey(name: "medium") final OriginalApiDto? medium,
    @JsonKey(name: "large") final OriginalApiDto? large,
  }) = _ProfilePictureApiDto;
  const ProfilePictureApiDto._();

  factory ProfilePictureApiDto.fromJson(Map<String, dynamic> json) =>
      _$ProfilePictureApiDtoFromJson(json);

  @override
  ProfilePicture toModel() => ProfilePicture(
        name: name,
        alternativeText: alternativeText,
        caption: caption,
        original: original?.toModel(),
        small: small?.toModel(),
        medium: medium?.toModel(),
        large: large?.toModel(),
      );
}

@freezed
class OriginalApiDto with _$OriginalApiDto implements ApiDto<Original> {
  const factory OriginalApiDto({
    @JsonKey(name: "url") final String? url,
    @JsonKey(name: "width") final int? width,
    @JsonKey(name: "height") final int? height,
  }) = _OriginalApiDto;
  const OriginalApiDto._();

  factory OriginalApiDto.fromJson(Map<String, dynamic> json) =>
      _$OriginalApiDtoFromJson(json);

  @override
  Original toModel() => Original(
        url: url,
        width: width,
        height: height,
      );
}

@freezed
class TeamsApiDto with _$TeamsApiDto implements ApiDto<Teams> {
  const factory TeamsApiDto({
    @JsonKey(name: "teamId") final String? teamId,
    @JsonKey(name: "name") final String? name,
    @JsonKey(name: "shortName") final String? shortName,
    @JsonKey(name: "primaryColour") final String? primaryColour,
    @JsonKey(name: "secondaryColour") final String? secondaryColour,
    @JsonKey(name: "logo") final ProfilePictureApiDto? logo,
    @JsonKey(name: "isHome") final bool? isHome,
    @JsonKey(name: "players") final List<PlayersApiDto>? players,
    @JsonKey(name: "squad") final List<SquadApiDto>? squad,
  }) = _TeamsApiDto;
  const TeamsApiDto._();

  factory TeamsApiDto.fromJson(Map<String, dynamic> json) =>
      _$TeamsApiDtoFromJson(json);

  @override
  Teams toModel() => Teams(
        teamId: teamId,
        name: name,
        shortName: shortName,
        primaryColour: primaryColour,
        secondaryColour: secondaryColour,
        logo: logo?.toModel(),
        isHome: isHome,
        players: players?.map((e) => e.toModel()).toList(),
        squad: squad?.map((e) => e.toModel()).toList(),
      );
}

@freezed
class PlayersApiDto with _$PlayersApiDto implements ApiDto<Players> {
  const factory PlayersApiDto({
    @JsonKey(name: "personId") final String? personId,
    @JsonKey(name: "firstName") final String? firstName,
    @JsonKey(name: "middleName") final String? middleName,
    @JsonKey(name: "lastName") final String? lastName,
    @JsonKey(name: "cardNameF") final String? cardNameF,
    @JsonKey(name: "cardNameS") final String? cardNameS,
    @JsonKey(name: "alphaName") final String? alphaName,
    @JsonKey(name: "profilePicture") final ProfilePictureApiDto? profilePicture,
    @JsonKey(name: "shirtNumber") final int? shirtNumber,
    @JsonKey(name: "wicketKeeper") final bool? wicketKeeper,
    @JsonKey(name: "substitute") final bool? substitute,
    @JsonKey(name: "captain") final bool? captain,
    @JsonKey(name: "viceCaptain") final bool? viceCaptain,
    @JsonKey(name: "battingHand") final String? battingHand,
    @JsonKey(name: "bowlingArm") final String? bowlingArm,
    @JsonKey(name: "primaryThrowingArm") final String? primaryThrowingArm,
    @JsonKey(name: "bowlingType") final String? bowlingType,
  }) = _PlayersApiDto;
  const PlayersApiDto._();

  factory PlayersApiDto.fromJson(Map<String, dynamic> json) =>
      _$PlayersApiDtoFromJson(json);

  @override
  Players toModel() => Players(
        personId: personId,
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        cardNameF: cardNameF,
        cardNameS: cardNameS,
        alphaName: alphaName,
        profilePicture: profilePicture?.toModel(),
        shirtNumber: shirtNumber,
        wicketKeeper: wicketKeeper,
        substitute: substitute,
        captain: captain,
        viceCaptain: viceCaptain,
        battingHand: battingHand,
        bowlingArm: bowlingArm,
        primaryThrowingArm: primaryThrowingArm,
        bowlingType: bowlingType,
      );
}

@freezed
class SquadApiDto with _$SquadApiDto implements ApiDto<Squad> {
  const factory SquadApiDto({
    @JsonKey(name: "personId") final String? personId,
    @JsonKey(name: "firstName") final String? firstName,
    @JsonKey(name: "middleName") final String? middleName,
    @JsonKey(name: "lastName") final String? lastName,
    @JsonKey(name: "cardNameF") final String? cardNameF,
    @JsonKey(name: "cardNameS") final String? cardNameS,
    @JsonKey(name: "alphaName") final String? alphaName,
    @JsonKey(name: "profilePicture") final ProfilePictureApiDto? profilePicture,
    @JsonKey(name: "shirtNumber") final int? shirtNumber,
  }) = _SquadApiDto;
  const SquadApiDto._();

  factory SquadApiDto.fromJson(Map<String, dynamic> json) =>
      _$SquadApiDtoFromJson(json);

  @override
  Squad toModel() => Squad(
        personId: personId,
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        cardNameF: cardNameF,
        cardNameS: cardNameS,
        alphaName: alphaName,
        profilePicture: profilePicture?.toModel(),
        shirtNumber: shirtNumber,
      );
}

@freezed
class InningsScoresApiDto
    with _$InningsScoresApiDto
    implements ApiDto<InningsScores> {
  const factory InningsScoresApiDto({
    @JsonKey(name: "inningsId") final String? inningsId,
    @JsonKey(name: "battingTeamId") final String? battingTeamId,
    @JsonKey(name: "bowlingTeamId") final String? bowlingTeamId,
    @JsonKey(name: "teamInningsNumber") final int? teamInningsNumber,
    @JsonKey(name: "matchInningsNumber") final int? matchInningsNumber,
    @JsonKey(name: "status") final String? status,
    @JsonKey(name: "followingOn") final bool? followingOn,
    @JsonKey(name: "isSuperOver") final bool? isSuperOver,
    @JsonKey(name: "reasonForClose") final String? reasonForClose,
    @JsonKey(name: "progressiveScores")
    final ProgressiveScoresApiDto? progressiveScores,
    @JsonKey(name: "battingPerformances")
    final List<CurrentBattersApiDto>? battingPerformances,
    @JsonKey(name: "bowlingPerformances")
    final List<CurrentBowlerApiDto>? bowlingPerformances,
    @JsonKey(name: "dls") final DlsApiDto? dls,
  }) = _InningsScoresApiDto;
  const InningsScoresApiDto._();

  factory InningsScoresApiDto.fromJson(Map<String, dynamic> json) =>
      _$InningsScoresApiDtoFromJson(json);

  @override
  InningsScores toModel() => InningsScores(
        inningsId: inningsId,
        battingTeamId: battingTeamId,
        bowlingTeamId: bowlingTeamId,
        teamInningsNumber: teamInningsNumber,
        matchInningsNumber: matchInningsNumber,
        status: status,
        followingOn: followingOn,
        isSuperOver: isSuperOver,
        reasonForClose: reasonForClose,
        progressiveScores: progressiveScores?.toModel(),
        dls: dls?.toModel(),
        battingPerformances:
            battingPerformances?.map((e) => e.toModel()).toList(),
        bowlingPerformances:
            bowlingPerformances?.map((e) => e.toModel()).toList(),
      );
}

@freezed
class ProgressiveScoresApiDto
    with _$ProgressiveScoresApiDto
    implements ApiDto<ProgressiveScores> {
  const factory ProgressiveScoresApiDto({
    @JsonKey(name: "byes") final int? byes,
    @JsonKey(name: "extras") final int? extras,
    @JsonKey(name: "legByes") final int? legByes,
    @JsonKey(name: "noBalls") final int? noBalls,
    @JsonKey(name: "penaltyRuns") final int? penaltyRuns,
    @JsonKey(name: "runs") final int? runs,
    @JsonKey(name: "wickets") final int? wickets,
    @JsonKey(name: "wides") final int? wides,
    @JsonKey(name: "oversBowled") final String? oversBowled,
    @JsonKey(name: "runRate") final String? runRate,
  }) = _ProgressiveScoresApiDto;
  const ProgressiveScoresApiDto._();

  factory ProgressiveScoresApiDto.fromJson(Map<String, dynamic> json) =>
      _$ProgressiveScoresApiDtoFromJson(json);

  @override
  ProgressiveScores toModel() => ProgressiveScores(
        byes: byes,
        extras: extras,
        legByes: legByes,
        noBalls: noBalls,
        penaltyRuns: penaltyRuns,
        runs: runs,
        wickets: wickets,
        wides: wides,
        oversBowled: oversBowled,
        runRate: runRate,
      );
}

@freezed
class DlsApiDto with _$DlsApiDto implements ApiDto<Dls> {
  const factory DlsApiDto({
    @JsonKey(name: "active") final bool? active,
    @JsonKey(name: "targetOvers") final int? targetOvers,
    @JsonKey(name: "targetScore") final int? targetScore,
  }) = _DlsApiDto;
  const DlsApiDto._();

  factory DlsApiDto.fromJson(Map<String, dynamic> json) =>
      _$DlsApiDtoFromJson(json);

  @override
  Dls toModel() => Dls(
        active: active,
        targetOvers: targetOvers,
        targetScore: targetScore,
      );
}

@freezed
class LiveSummaryApiDto
    with _$LiveSummaryApiDto
    implements ApiDto<LiveSummary> {
  const factory LiveSummaryApiDto({
    @JsonKey(name: "currentBowler") final CurrentBowlerApiDto? currentBowler,
    @JsonKey(name: "currentBatters")
    final List<CurrentBattersApiDto>? currentBatters,
    @JsonKey(name: "currentPartnership")
    final CurrentPartnershipApiDto? currentPartnership,
    @JsonKey(name: "recentBalls") final List<RecentBallsApiDto>? recentBalls,
  }) = _LiveSummaryApiDto;
  const LiveSummaryApiDto._();

  factory LiveSummaryApiDto.fromJson(Map<String, dynamic> json) =>
      _$LiveSummaryApiDtoFromJson(json);

  @override
  LiveSummary toModel() => LiveSummary(
        currentBowler: currentBowler?.toModel(),
        currentBatters: currentBatters?.map((e) => e.toModel()).toList(),
        currentPartnership: currentPartnership?.toModel(),
        recentBalls: recentBalls?.map((e) => e.toModel()).toList(),
      );
}

@freezed
class CurrentBowlerApiDto
    with _$CurrentBowlerApiDto
    implements ApiDto<CurrentBowler> {
  const factory CurrentBowlerApiDto({
    @JsonKey(name: "personId") final String? personId,
    @JsonKey(name: "firstName") final String? firstName,
    @JsonKey(name: "middleName") final String? middleName,
    @JsonKey(name: "lastName") final String? lastName,
    @JsonKey(name: "cardNameF") final String? cardNameF,
    @JsonKey(name: "cardNameS") final String? cardNameS,
    @JsonKey(name: "alphaName") final String? alphaName,
    @JsonKey(name: "profilePicture") final ProfilePictureApiDto? profilePicture,
    @JsonKey(name: "order") final int? order,
    @JsonKey(name: "isBowling") final bool? isBowling,
    @JsonKey(name: "maidens") final int? maidens,
    @JsonKey(name: "runs") final int? runs,
    @JsonKey(name: "dots") final int? dots,
    @JsonKey(name: "overs") final String? overs,
    @JsonKey(name: "wickets") final int? wickets,
    @JsonKey(name: "economy") final String? economy,
    @JsonKey(name: "noBalls") final int? noBalls,
    @JsonKey(name: "wides") final int? wides,
  }) = _CurrentBowlerApiDto;
  const CurrentBowlerApiDto._();

  factory CurrentBowlerApiDto.fromJson(Map<String, dynamic> json) =>
      _$CurrentBowlerApiDtoFromJson(json);

  @override
  CurrentBowler toModel() => CurrentBowler(
        personId: personId,
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        cardNameF: cardNameF,
        cardNameS: cardNameS,
        alphaName: alphaName,
        profilePicture: profilePicture?.toModel(),
        order: order,
        isBowling: isBowling,
        maidens: maidens,
        runs: runs,
        dots: dots,
        overs: overs,
        wickets: wickets,
        economy: economy,
        noBalls: noBalls,
        wides: wides,
      );
}

@freezed
class CurrentBattersApiDto
    with _$CurrentBattersApiDto
    implements ApiDto<CurrentBatters> {
  const factory CurrentBattersApiDto({
    @JsonKey(name: "personId") final String? personId,
    @JsonKey(name: "firstName") final String? firstName,
    @JsonKey(name: "middleName") final String? middleName,
    @JsonKey(name: "lastName") final String? lastName,
    @JsonKey(name: "cardNameF") final String? cardNameF,
    @JsonKey(name: "cardNameS") final String? cardNameS,
    @JsonKey(name: "alphaName") final String? alphaName,
    @JsonKey(name: "profilePicture") final ProfilePictureApiDto? profilePicture,
    @JsonKey(name: "notOut") final bool? notOut,
    @JsonKey(name: "onStrike") final bool? onStrike,
    @JsonKey(name: "order") final int? order,
    @JsonKey(name: "didNotBat") final bool? didNotBat,
    @JsonKey(name: "balls") final int? balls,
    @JsonKey(name: "runs") final int? runs,
    @JsonKey(name: "strikeRate") final String? strikeRate,
    @JsonKey(name: "dots") final int? dots,
    @JsonKey(name: "ones") final int? ones,
    @JsonKey(name: "twos") final int? twos,
    @JsonKey(name: "threes") final int? threes,
    @JsonKey(name: "fours") final int? fours,
    @JsonKey(name: "sixes") final int? sixes,
    @JsonKey(name: "totalMins") final int? totalMins,
    @JsonKey(name: "text") final String? text,
    @JsonKey(name: "dismissal") final DismissalApiDto? dismissal,
  }) = _CurrentBattersApiDto;
  const CurrentBattersApiDto._();

  factory CurrentBattersApiDto.fromJson(Map<String, dynamic> json) =>
      _$CurrentBattersApiDtoFromJson(json);

  @override
  CurrentBatters toModel() => CurrentBatters(
        personId: personId,
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        cardNameF: cardNameF,
        cardNameS: cardNameS,
        alphaName: alphaName,
        profilePicture: profilePicture?.toModel(),
        notOut: notOut,
        onStrike: onStrike,
        order: order,
        didNotBat: didNotBat,
        balls: balls,
        runs: runs,
        strikeRate: strikeRate,
        dots: dots,
        ones: ones,
        twos: twos,
        threes: threes,
        fours: fours,
        sixes: sixes,
        totalMins: totalMins,
        text: text,
        dismissal: dismissal?.toModel(),
      );
}

@freezed
class DismissalApiDto with _$DismissalApiDto implements ApiDto<Dismissal> {
  const factory DismissalApiDto({
    @JsonKey(name: "type") final String? type,
    @JsonKey(name: "bowler") final BowlerApiDto? bowler,
    @JsonKey(name: "fielders") final List<FieldersApiDto>? fielders,
    @JsonKey(name: "battersCrossed") final bool? battersCrossed,
    @JsonKey(name: "wicketNumber") final int? wicketNumber,
    @JsonKey(name: "fowRuns") final int? fowRuns,
    @JsonKey(name: "fowOver") final String? fowOver,
  }) = _DismissalApiDto;
  const DismissalApiDto._();

  factory DismissalApiDto.fromJson(Map<String, dynamic> json) =>
      _$DismissalApiDtoFromJson(json);

  @override
  Dismissal toModel() => Dismissal(
        type: type,
        bowler: bowler?.toModel(),
        fielders: fielders?.map((e) => e.toModel()).toList(),
        battersCrossed: battersCrossed,
        wicketNumber: wicketNumber,
        fowRuns: fowRuns,
        fowOver: fowOver,
      );
}

@freezed
class BowlerApiDto with _$BowlerApiDto implements ApiDto<Bowler> {
  const factory BowlerApiDto({
    @JsonKey(name: "personId") final String? personId,
    @JsonKey(name: "firstName") final String? firstName,
    @JsonKey(name: "middleName") final String? middleName,
    @JsonKey(name: "lastName") final String? lastName,
    @JsonKey(name: "cardNameF") final String? cardNameF,
    @JsonKey(name: "cardNameS") final String? cardNameS,
    @JsonKey(name: "alphaName") final String? alphaName,
    @JsonKey(name: "profilePicture") final ProfilePictureApiDto? profilePicture,
  }) = _BowlerApiDto;
  const BowlerApiDto._();

  factory BowlerApiDto.fromJson(Map<String, dynamic> json) =>
      _$BowlerApiDtoFromJson(json);

  @override
  Bowler toModel() => Bowler(
        personId: personId,
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        cardNameF: cardNameF,
        cardNameS: cardNameS,
        alphaName: alphaName,
        profilePicture: profilePicture?.toModel(),
      );
}

@freezed
class FieldersApiDto with _$FieldersApiDto implements ApiDto<Fielders> {
  const factory FieldersApiDto({
    @JsonKey(name: "personId") final String? personId,
    @JsonKey(name: "firstName") final String? firstName,
    @JsonKey(name: "middleName") final String? middleName,
    @JsonKey(name: "lastName") final String? lastName,
    @JsonKey(name: "cardNameF") final String? cardNameF,
    @JsonKey(name: "cardNameS") final String? cardNameS,
    @JsonKey(name: "alphaName") final String? alphaName,
    @JsonKey(name: "profilePicture") final ProfilePictureApiDto? profilePicture,
    @JsonKey(name: "order") final int? order,
  }) = _FieldersApiDto;
  const FieldersApiDto._();

  factory FieldersApiDto.fromJson(Map<String, dynamic> json) =>
      _$FieldersApiDtoFromJson(json);

  @override
  Fielders toModel() => Fielders(
        personId: personId,
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        cardNameF: cardNameF,
        cardNameS: cardNameS,
        alphaName: alphaName,
        profilePicture: profilePicture?.toModel(),
        order: order,
      );
}

@freezed
class CurrentPartnershipApiDto
    with _$CurrentPartnershipApiDto
    implements ApiDto<CurrentPartnership> {
  const factory CurrentPartnershipApiDto({
    @JsonKey(name: "wicketNumber") final int? wicketNumber,
    @JsonKey(name: "startOver") final String? startOver,
    @JsonKey(name: "endOver") final String? endOver,
    @JsonKey(name: "isUnbeaten") final bool? isUnbeaten,
    @JsonKey(name: "balls") final int? balls,
    @JsonKey(name: "totalRuns") final int? totalRuns,
    @JsonKey(name: "extraRuns") final int? extraRuns,
    @JsonKey(name: "players") final List<PlayersApiDto>? players,
  }) = _CurrentPartnershipApiDto;
  const CurrentPartnershipApiDto._();

  factory CurrentPartnershipApiDto.fromJson(Map<String, dynamic> json) =>
      _$CurrentPartnershipApiDtoFromJson(json);

  @override
  CurrentPartnership toModel() => CurrentPartnership(
        wicketNumber: wicketNumber,
        startOver: startOver,
        endOver: endOver,
        isUnbeaten: isUnbeaten,
        balls: balls,
        totalRuns: totalRuns,
        extraRuns: extraRuns,
        players: players?.map((e) => e.toModel()).toList(),
      );
}

@freezed
class RecentBallsApiDto
    with _$RecentBallsApiDto
    implements ApiDto<RecentBalls> {
  const factory RecentBallsApiDto({
    @JsonKey(name: "ballNumber") final int? ballNumber,
    @JsonKey(name: "ballDisplayNumber") final int? ballDisplayNumber,
    @JsonKey(name: "shortDescription") final String? shortDescription,
    @JsonKey(name: "runsBat") final int? runsBat,
    @JsonKey(name: "runsExtra") final int? runsExtra,
    @JsonKey(name: "extrasType") final String? extrasType,
    @JsonKey(name: "overNumber") final int? overNumber,
    @JsonKey(name: "freeHit") final bool? freeHit,
    @JsonKey(name: "description") final String? description,
    @JsonKey(name: "ballSpeed") final String? ballSpeed,
    @JsonKey(name: "endOfOver") final bool? endOfOver,
    @JsonKey(name: "bowler") final BowlerApiDto? bowler,
    @JsonKey(name: "batter") final BowlerApiDto? batter,
    @JsonKey(name: "inningsProgressiveScore")
    final InningsProgressiveScoreApiDto? inningsProgressiveScore,
  }) = _RecentBallsApiDto;
  const RecentBallsApiDto._();

  factory RecentBallsApiDto.fromJson(Map<String, dynamic> json) =>
      _$RecentBallsApiDtoFromJson(json);

  @override
  RecentBalls toModel() => RecentBalls(
        ballNumber: ballNumber,
        ballDisplayNumber: ballDisplayNumber,
        shortDescription: shortDescription,
        runsBat: runsBat,
        runsExtra: runsExtra,
        extrasType: extrasType,
        overNumber: overNumber,
        freeHit: freeHit,
        description: description,
        ballSpeed: ballSpeed,
        endOfOver: endOfOver,
        bowler: bowler?.toModel(),
        batter: batter?.toModel(),
        inningsProgressiveScore: inningsProgressiveScore?.toModel(),
      );
}

@freezed
class InningsProgressiveScoreApiDto
    with _$InningsProgressiveScoreApiDto
    implements ApiDto<InningsProgressiveScore> {
  const factory InningsProgressiveScoreApiDto({
    @JsonKey(name: "runs") final int? runs,
    @JsonKey(name: "wickets") final int? wickets,
  }) = _InningsProgressiveScoreApiDto;
  const InningsProgressiveScoreApiDto._();

  factory InningsProgressiveScoreApiDto.fromJson(Map<String, dynamic> json) =>
      _$InningsProgressiveScoreApiDtoFromJson(json);

  @override
  InningsProgressiveScore toModel() => InningsProgressiveScore(
        runs: runs,
        wickets: wickets,
      );
}

@freezed
class TopPerformersApiDto
    with _$TopPerformersApiDto
    implements ApiDto<TopPerformers> {
  const factory TopPerformersApiDto({
    @JsonKey(name: "playerOfMatch") final PlayerOfMatchApiDto? playerOfMatch,
    @JsonKey(name: "mostRuns") final MostRunsApiDto? mostRuns,
    @JsonKey(name: "mostWickets") final MostWicketsApiDto? mostWickets,
  }) = _TopPerformersApiDto;
  const TopPerformersApiDto._();

  factory TopPerformersApiDto.fromJson(Map<String, dynamic> json) =>
      _$TopPerformersApiDtoFromJson(json);

  @override
  TopPerformers toModel() => TopPerformers(
        playerOfMatch: playerOfMatch?.toModel(),
        mostRuns: mostRuns?.toModel(),
        mostWickets: mostWickets?.toModel(),
      );
}

@freezed
class PlayerOfMatchApiDto
    with _$PlayerOfMatchApiDto
    implements ApiDto<PlayerOfMatch> {
  const factory PlayerOfMatchApiDto({
    @JsonKey(name: "player") final PlayersApiDto? player,
    @JsonKey(name: "team") final TeamApiDto? team,
    @JsonKey(name: "battingPerformances")
    final List<PlayersApiDto>? battingPerformances,
    @JsonKey(name: "bowlingPerformances")
    final List<PlayersApiDto>? bowlingPerformances,
  }) = _PlayerOfMatchApiDto;
  const PlayerOfMatchApiDto._();

  factory PlayerOfMatchApiDto.fromJson(Map<String, dynamic> json) =>
      _$PlayerOfMatchApiDtoFromJson(json);

  @override
  PlayerOfMatch toModel() => PlayerOfMatch(
        player: player?.toModel(),
        team: team?.toModel(),
        battingPerformances:
            battingPerformances?.map((e) => e.toModel()).toList(),
        bowlingPerformances:
            bowlingPerformances?.map((e) => e.toModel()).toList(),
      );
}

@freezed
class TeamApiDto with _$TeamApiDto implements ApiDto<Team> {
  const factory TeamApiDto({
    @JsonKey(name: "teamId") final String? teamId,
    @JsonKey(name: "name") final String? name,
    @JsonKey(name: "shortName") final String? shortName,
    @JsonKey(name: "primaryColour") final String? primaryColour,
    @JsonKey(name: "secondaryColour") final String? secondaryColour,
    @JsonKey(name: "logo") final ProfilePictureApiDto? logo,
  }) = _TeamApiDto;
  const TeamApiDto._();

  factory TeamApiDto.fromJson(Map<String, dynamic> json) =>
      _$TeamApiDtoFromJson(json);

  @override
  Team toModel() => Team(
        teamId: teamId,
        name: name,
        shortName: shortName,
        primaryColour: primaryColour,
        secondaryColour: secondaryColour,
        logo: logo?.toModel(),
      );
}

// @freezed
// class OriginalApiDto with _$OriginalApiDto implements ApiDto<Original> {
//   const factory OriginalApiDto() = _OriginalApiDto;
//   const OriginalApiDto._();

//   factory OriginalApiDto.fromJson(Map<String, dynamic> json) =>
//       _$OriginalApiDtoFromJson(json);

//   @override
//   Original toModel() => Original();
// }

@freezed
class MostRunsApiDto with _$MostRunsApiDto implements ApiDto<MostRuns> {
  const factory MostRunsApiDto({
    @JsonKey(name: "player") final PlayersApiDto? player,
    @JsonKey(name: "team") final TeamApiDto? team,
    @JsonKey(name: "runsTotal") final int? runsTotal,
  }) = _MostRunsApiDto;
  const MostRunsApiDto._();

  factory MostRunsApiDto.fromJson(Map<String, dynamic> json) =>
      _$MostRunsApiDtoFromJson(json);

  @override
  MostRuns toModel() => MostRuns(
        player: player?.toModel(),
        team: team?.toModel(),
        runsTotal: runsTotal,
      );
}

@freezed
class MostWicketsApiDto
    with _$MostWicketsApiDto
    implements ApiDto<MostWickets> {
  const factory MostWicketsApiDto({
    @JsonKey(name: "player") final PlayersApiDto? player,
    @JsonKey(name: "team") final TeamApiDto? team,
    @JsonKey(name: "wicketsTotal") final int? wicketsTotal,
  }) = _MostWicketsApiDto;
  const MostWicketsApiDto._();

  factory MostWicketsApiDto.fromJson(Map<String, dynamic> json) =>
      _$MostWicketsApiDtoFromJson(json);

  @override
  MostWickets toModel() => MostWickets(
        player: player?.toModel(),
        team: team?.toModel(),
        wicketsTotal: wicketsTotal,
      );
}

@freezed
class InningsBallsApiDto
    with _$InningsBallsApiDto
    implements ApiDto<InningsBalls> {
  const factory InningsBallsApiDto({
    @JsonKey(name: "inningsId") final String? inningsId,
    @JsonKey(name: "battingTeamId") final String? battingTeamId,
    @JsonKey(name: "bowlingTeamId") final String? bowlingTeamId,
    @JsonKey(name: "teamInningsNumber") final int? teamInningsNumber,
    @JsonKey(name: "matchInningsNumber") final int? matchInningsNumber,
    @JsonKey(name: "status") final String? status,
    @JsonKey(name: "followingOn") final bool? followingOn,
    @JsonKey(name: "isSuperOver") final bool? isSuperOver,
    @JsonKey(name: "reasonForClose") final String? reasonForClose,
    @JsonKey(name: "balls") final List<BallsApiDto>? balls,
  }) = _InningsBallsApiDto;
  const InningsBallsApiDto._();

  factory InningsBallsApiDto.fromJson(Map<String, dynamic> json) =>
      _$InningsBallsApiDtoFromJson(json);

  @override
  InningsBalls toModel() => InningsBalls(
        inningsId: inningsId,
        battingTeamId: battingTeamId,
        bowlingTeamId: bowlingTeamId,
        teamInningsNumber: teamInningsNumber,
        matchInningsNumber: matchInningsNumber,
        status: status,
        followingOn: followingOn,
        isSuperOver: isSuperOver,
        reasonForClose: reasonForClose,
        balls: balls?.map((e) => e.toModel()).toList(),
      );
}

@freezed
class BallsApiDto with _$BallsApiDto implements ApiDto<Balls> {
  const factory BallsApiDto({
    @JsonKey(name: "ballNumber") final int? ballNumber,
    @JsonKey(name: "ballDisplayNumber") final int? ballDisplayNumber,
    @JsonKey(name: "shortDescription") final String? shortDescription,
    @JsonKey(name: "runsBat") final int? runsBat,
    @JsonKey(name: "runsExtra") final int? runsExtra,
    @JsonKey(name: "overNumber") final int? overNumber,
    @JsonKey(name: "freeHit") final bool? freeHit,
    @JsonKey(name: "endOfOver") final bool? endOfOver,
    @JsonKey(name: "description") final String? description,
    @JsonKey(name: "bowler") final BowlerApiDto? bowler,
    @JsonKey(name: "batter") final BowlerApiDto? batter,
    @JsonKey(name: "inningsProgressiveScore")
    final InningsProgressiveScoreApiDto? inningsProgressiveScore,
  }) = _BallsApiDto;
  const BallsApiDto._();

  factory BallsApiDto.fromJson(Map<String, dynamic> json) =>
      _$BallsApiDtoFromJson(json);

  @override
  Balls toModel() => Balls(
        ballNumber: ballNumber,
        ballDisplayNumber: ballDisplayNumber,
        shortDescription: shortDescription,
        runsBat: runsBat,
        runsExtra: runsExtra,
        overNumber: overNumber,
        freeHit: freeHit,
        endOfOver: endOfOver,
        description: description,
        bowler: bowler?.toModel(),
        batter: batter?.toModel(),
        inningsProgressiveScore: inningsProgressiveScore?.toModel(),
      );
}

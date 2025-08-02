import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/mappers/ui_model.dart';
import '../../../data/models/api/match_details/match_details_api_dto.dart';

part 'match_details.freezed.dart';

@freezed
class MatchDetails with _$MatchDetails implements UIModel<MatchDetailsApiDto> {
  const factory MatchDetails({
    final String? matchId,
    final String? title,
    final String? description,
    final String? className,
    final String? format,
    final String? coverageLevel,
    final int? ballsPerOver,
    final int? oversPerInnings,
    final String? startDate,
    final String? endDate,
    final int? currentDayNum,
    final String? status,
    final String? stateOfPlay,
    final String? currentInningsId,
    final Competition? competition,
    final Venue? venue,
    final Toss? toss,
    final AdditionalData? additionalData,
    final FeatureFlags? featureFlags,
    final List<Officials>? officials,
    final List<Teams>? teams,
    final List<InningsScores>? inningsScores,
    final LiveSummary? liveSummary,
    final TopPerformers? topPerformers,
    final List<InningsScores>? inningsScorecards,
    final List<InningsBalls>? inningsBalls,
    final String? umpires,
    final String? thirdUmpire,
    final String? fourthUmpire,
    final String? referee,
  }) = _MatchDetails;
  const MatchDetails._();

  @override
  MatchDetailsApiDto toApiDto() => MatchDetailsApiDto(
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
        competition: competition?.toApiDto(),
        venue: venue?.toApiDto(),
        toss: toss?.toApiDto(),
        additionalData: additionalData?.toApiDto(),
        featureFlags: featureFlags?.toApiDto(),
        officials: officials?.map((e) => e.toApiDto()).toList(),
        teams: teams?.map((e) => e.toApiDto()).toList(),
        inningsScores: inningsScores?.map((e) => e.toApiDto()).toList(),
        liveSummary: liveSummary?.toApiDto(),
        topPerformers: topPerformers?.toApiDto(),
      );
}

@freezed
class Competition with _$Competition implements UIModel<CompetitionApiDto> {
  const factory Competition({
    final String? competitionId,
    final String? name,
    final String? stageId,
    final String? poolId,
    final int? matchNumber,
    final String? gender,
  }) = _Competition;
  const Competition._();

  @override
  CompetitionApiDto toApiDto() => CompetitionApiDto(
        competitionId: competitionId,
        name: name,
        stageId: stageId,
        poolId: poolId,
        matchNumber: matchNumber,
        gender: gender,
      );
}

@freezed
class Venue with _$Venue implements UIModel<VenueApiDto> {
  const factory Venue({
    final String? venueId,
    final String? name,
    final String? fullName,
    final String? knownAs,
  }) = _Venue;
  const Venue._();

  @override
  VenueApiDto toApiDto() => VenueApiDto(
        venueId: venueId,
        name: name,
        fullName: fullName,
        knownAs: knownAs,
      );
}

@freezed
class Toss with _$Toss implements UIModel<TossApiDto> {
  const factory Toss({
    final String? wonById,
    final String? wonByName,
    final String? decision,
  }) = _Toss;
  const Toss._();

  @override
  TossApiDto toApiDto() => TossApiDto(
        wonById: wonById,
        wonByName: wonByName,
        decision: decision,
      );
}

@freezed
class AdditionalData
    with _$AdditionalData
    implements UIModel<AdditionalDataApiDto> {
  const factory AdditionalData({
    final String? ticketingUrl,
    final String? reportUrl,
    final String? highlightsUrl,
  }) = _AdditionalData;
  const AdditionalData._();

  @override
  AdditionalDataApiDto toApiDto() => AdditionalDataApiDto(
        ticketingUrl: ticketingUrl,
        reportUrl: reportUrl,
        highlightsUrl: highlightsUrl,
      );
}

@freezed
class FeatureFlags with _$FeatureFlags implements UIModel<FeatureFlagsApiDto> {
  const factory FeatureFlags({
    final bool? showFielding,
    final bool? showLadder,
  }) = _FeatureFlags;
  const FeatureFlags._();

  @override
  FeatureFlagsApiDto toApiDto() => FeatureFlagsApiDto(
        showFielding: showFielding,
        showLadder: showLadder,
      );
}

@freezed
class Officials with _$Officials implements UIModel<OfficialsApiDto> {
  const factory Officials({
    final String? personId,
    final String? firstName,
    final String? middleName,
    final String? lastName,
    final String? cardNameF,
    final String? cardNameS,
    final String? alphaName,
    final ProfilePicture? profilePicture,
    final String? matchRole,
  }) = _Officials;
  const Officials._();

  @override
  OfficialsApiDto toApiDto() => OfficialsApiDto(
        personId: personId,
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        cardNameF: cardNameF,
        cardNameS: cardNameS,
        alphaName: alphaName,
        profilePicture: profilePicture?.toApiDto(),
        matchRole: matchRole,
      );
}

@freezed
class Original with _$Original implements UIModel<OriginalApiDto> {
  const factory Original({
    final String? url,
    final int? width,
    final int? height,
  }) = _Original;
  const Original._();

  @override
  OriginalApiDto toApiDto() => OriginalApiDto(
        url: url,
        width: width,
        height: height,
      );
}

@freezed
class Teams with _$Teams implements UIModel<TeamsApiDto> {
  const factory Teams({
    final String? teamId,
    final String? name,
    final String? shortName,
    final String? primaryColour,
    final String? secondaryColour,
    final ProfilePicture? logo,
    final bool? isHome,
    final List<Players>? players,
    final List<Squad>? squad,
  }) = _Teams;
  const Teams._();

  @override
  TeamsApiDto toApiDto() => TeamsApiDto(
        teamId: teamId,
        name: name,
        shortName: shortName,
        primaryColour: primaryColour,
        secondaryColour: secondaryColour,
        logo: logo?.toApiDto(),
        isHome: isHome,
        players: players?.map((e) => e.toApiDto()).toList(),
        squad: squad?.map((e) => e.toApiDto()).toList(),
      );
}

@freezed
class Players with _$Players implements UIModel<PlayersApiDto> {
  const factory Players({
    final String? personId,
    final String? firstName,
    final String? middleName,
    final String? lastName,
    final String? cardNameF,
    final String? cardNameS,
    final String? alphaName,
    final ProfilePicture? profilePicture,
    final int? shirtNumber,
    final bool? wicketKeeper,
    final bool? substitute,
    final bool? captain,
    final bool? viceCaptain,
    final String? battingHand,
    final String? bowlingArm,
    final String? primaryThrowingArm,
    final String? bowlingType,
  }) = _Players;
  const Players._();

  @override
  PlayersApiDto toApiDto() => PlayersApiDto(
        personId: personId,
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        cardNameF: cardNameF,
        cardNameS: cardNameS,
        alphaName: alphaName,
        profilePicture: profilePicture?.toApiDto(),
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
class Squad with _$Squad implements UIModel<SquadApiDto> {
  const factory Squad({
    final String? personId,
    final String? firstName,
    final String? middleName,
    final String? lastName,
    final String? cardNameF,
    final String? cardNameS,
    final String? alphaName,
    final ProfilePicture? profilePicture,
    final int? shirtNumber,
  }) = _Squad;
  const Squad._();

  @override
  SquadApiDto toApiDto() => SquadApiDto(
        personId: personId,
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        cardNameF: cardNameF,
        cardNameS: cardNameS,
        alphaName: alphaName,
        profilePicture: profilePicture?.toApiDto(),
        shirtNumber: shirtNumber,
      );
}

@freezed
class InningsScores
    with _$InningsScores
    implements UIModel<InningsScoresApiDto> {
  const factory InningsScores({
    final String? inningsId,
    final String? battingTeamId,
    final String? bowlingTeamId,
    final int? teamInningsNumber,
    final int? matchInningsNumber,
    final String? status,
    final bool? followingOn,
    final bool? isSuperOver,
    final String? reasonForClose,
    final ProgressiveScores? progressiveScores,
    final Dls? dls,
    final List<CurrentBowler>? bowlingPerformances,
    final List<CurrentBatters>? battingPerformances,
  }) = _InningsScores;
  const InningsScores._();

  @override
  InningsScoresApiDto toApiDto() => InningsScoresApiDto(
        inningsId: inningsId,
        battingTeamId: battingTeamId,
        bowlingTeamId: bowlingTeamId,
        teamInningsNumber: teamInningsNumber,
        matchInningsNumber: matchInningsNumber,
        status: status,
        followingOn: followingOn,
        isSuperOver: isSuperOver,
        reasonForClose: reasonForClose,
        progressiveScores: progressiveScores?.toApiDto(),
        dls: dls?.toApiDto(),
      );
}

@freezed
class ProgressiveScores
    with _$ProgressiveScores
    implements UIModel<ProgressiveScoresApiDto> {
  const factory ProgressiveScores({
    final int? byes,
    final int? extras,
    final int? legByes,
    final int? noBalls,
    final int? penaltyRuns,
    final int? runs,
    final int? wickets,
    final int? wides,
    final String? oversBowled,
    final String? runRate,
  }) = _ProgressiveScores;
  const ProgressiveScores._();

  @override
  ProgressiveScoresApiDto toApiDto() => ProgressiveScoresApiDto(
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
class Dls with _$Dls implements UIModel<DlsApiDto> {
  const factory Dls({
    final bool? active,
    final int? targetOvers,
    final int? targetScore,
  }) = _Dls;
  const Dls._();

  @override
  DlsApiDto toApiDto() => DlsApiDto(
        active: active,
        targetOvers: targetOvers,
        targetScore: targetScore,
      );
}

@freezed
class LiveSummary with _$LiveSummary implements UIModel<LiveSummaryApiDto> {
  const factory LiveSummary({
    final CurrentBowler? currentBowler,
    final List<CurrentBatters>? currentBatters,
    final CurrentPartnership? currentPartnership,
    final List<RecentBalls>? recentBalls,
  }) = _LiveSummary;
  const LiveSummary._();

  @override
  LiveSummaryApiDto toApiDto() => LiveSummaryApiDto(
        currentBowler: currentBowler?.toApiDto(),
        currentBatters: currentBatters?.map((e) => e.toApiDto()).toList(),
        currentPartnership: currentPartnership?.toApiDto(),
        recentBalls: recentBalls?.map((e) => e.toApiDto()).toList(),
      );
}

@freezed
class CurrentBowler
    with _$CurrentBowler
    implements UIModel<CurrentBowlerApiDto> {
  const factory CurrentBowler({
    final String? personId,
    final String? firstName,
    final String? middleName,
    final String? lastName,
    final String? cardNameF,
    final String? cardNameS,
    final String? alphaName,
    final ProfilePicture? profilePicture,
    final int? order,
    final bool? isBowling,
    final int? maidens,
    final int? runs,
    final int? dots,
    final String? overs,
    final int? wickets,
    final String? economy,
    final int? noBalls,
    final int? wides,
  }) = _CurrentBowler;
  const CurrentBowler._();

  @override
  CurrentBowlerApiDto toApiDto() => CurrentBowlerApiDto(
        personId: personId,
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        cardNameF: cardNameF,
        cardNameS: cardNameS,
        alphaName: alphaName,
        profilePicture: profilePicture?.toApiDto(),
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
class CurrentBatters
    with _$CurrentBatters
    implements UIModel<CurrentBattersApiDto> {
  const factory CurrentBatters({
    final String? personId,
    final String? firstName,
    final String? middleName,
    final String? lastName,
    final String? cardNameF,
    final String? cardNameS,
    final String? alphaName,
    final ProfilePicture? profilePicture,
    final bool? notOut,
    final bool? onStrike,
    final int? order,
    final bool? didNotBat,
    final int? balls,
    final int? runs,
    final String? strikeRate,
    final int? dots,
    final int? ones,
    final int? twos,
    final int? threes,
    final int? fours,
    final int? sixes,
    final int? totalMins,
    final String? text,
    final Dismissal? dismissal,
  }) = _CurrentBatters;
  const CurrentBatters._();

  @override
  CurrentBattersApiDto toApiDto() => CurrentBattersApiDto(
        personId: personId,
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        cardNameF: cardNameF,
        cardNameS: cardNameS,
        alphaName: alphaName,
        profilePicture: profilePicture?.toApiDto(),
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
        dismissal: dismissal?.toApiDto(),
      );
}

@freezed
class Dismissal with _$Dismissal implements UIModel<DismissalApiDto> {
  const factory Dismissal({
    final String? type,
    final Bowler? bowler,
    final List<Fielders>? fielders,
    final bool? battersCrossed,
    final int? wicketNumber,
    final int? fowRuns,
    final String? fowOver,
  }) = _Dismissal;
  const Dismissal._();

  @override
  DismissalApiDto toApiDto() => DismissalApiDto(
        type: type,
        bowler: bowler?.toApiDto(),
        fielders: fielders?.map((e) => e.toApiDto()).toList(),
        battersCrossed: battersCrossed,
        wicketNumber: wicketNumber,
        fowRuns: fowRuns,
        fowOver: fowOver,
      );
}

@freezed
class Bowler with _$Bowler implements UIModel<BowlerApiDto> {
  const factory Bowler({
    final String? personId,
    final String? firstName,
    final String? middleName,
    final String? lastName,
    final String? cardNameF,
    final String? cardNameS,
    final String? alphaName,
    final ProfilePicture? profilePicture,
  }) = _Bowler;
  const Bowler._();

  @override
  BowlerApiDto toApiDto() => BowlerApiDto(
        personId: personId,
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        cardNameF: cardNameF,
        cardNameS: cardNameS,
        alphaName: alphaName,
        profilePicture: profilePicture?.toApiDto(),
      );
}

@freezed
class Fielders with _$Fielders implements UIModel<FieldersApiDto> {
  const factory Fielders({
    final String? personId,
    final String? firstName,
    final String? middleName,
    final String? lastName,
    final String? cardNameF,
    final String? cardNameS,
    final String? alphaName,
    final ProfilePicture? profilePicture,
    final int? order,
  }) = _Fielders;
  const Fielders._();

  @override
  FieldersApiDto toApiDto() => FieldersApiDto(
        personId: personId,
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        cardNameF: cardNameF,
        cardNameS: cardNameS,
        alphaName: alphaName,
        profilePicture: profilePicture?.toApiDto(),
        order: order,
      );
}

@freezed
class CurrentPartnership
    with _$CurrentPartnership
    implements UIModel<CurrentPartnershipApiDto> {
  const factory CurrentPartnership({
    final int? wicketNumber,
    final String? startOver,
    final String? endOver,
    final bool? isUnbeaten,
    final int? balls,
    final int? totalRuns,
    final int? extraRuns,
    final List<Players>? players,
  }) = _CurrentPartnership;
  const CurrentPartnership._();

  @override
  CurrentPartnershipApiDto toApiDto() => CurrentPartnershipApiDto(
        wicketNumber: wicketNumber,
        startOver: startOver,
        endOver: endOver,
        isUnbeaten: isUnbeaten,
        balls: balls,
        totalRuns: totalRuns,
        extraRuns: extraRuns,
        players: players?.map((e) => e.toApiDto()).toList(),
      );
}

@freezed
class RecentBalls with _$RecentBalls implements UIModel<RecentBallsApiDto> {
  const factory RecentBalls({
    final int? ballNumber,
    final int? ballDisplayNumber,
    final String? shortDescription,
    final int? runsBat,
    final int? runsExtra,
    final String? extrasType,
    final int? overNumber,
    final bool? freeHit,
    final String? description,
    final String? ballSpeed,
    final bool? endOfOver,
    final Bowler? bowler,
    final Bowler? batter,
    final InningsProgressiveScore? inningsProgressiveScore,
  }) = _RecentBalls;
  const RecentBalls._();

  @override
  RecentBallsApiDto toApiDto() => RecentBallsApiDto(
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
        bowler: bowler?.toApiDto(),
        batter: batter?.toApiDto(),
        inningsProgressiveScore: inningsProgressiveScore?.toApiDto(),
      );
}

@freezed
class InningsProgressiveScore
    with _$InningsProgressiveScore
    implements UIModel<InningsProgressiveScoreApiDto> {
  const factory InningsProgressiveScore({
    final int? runs,
    final int? wickets,
  }) = _InningsProgressiveScore;
  const InningsProgressiveScore._();

  @override
  InningsProgressiveScoreApiDto toApiDto() => InningsProgressiveScoreApiDto(
        runs: runs,
        wickets: wickets,
      );
}

@freezed
class TopPerformers
    with _$TopPerformers
    implements UIModel<TopPerformersApiDto> {
  const factory TopPerformers({
    final PlayerOfMatch? playerOfMatch,
    final MostRuns? mostRuns,
    final MostWickets? mostWickets,
  }) = _TopPerformers;
  const TopPerformers._();

  @override
  TopPerformersApiDto toApiDto() => TopPerformersApiDto(
        playerOfMatch: playerOfMatch?.toApiDto(),
        mostRuns: mostRuns?.toApiDto(),
        mostWickets: mostWickets?.toApiDto(),
      );
}

@freezed
class PlayerOfMatch
    with _$PlayerOfMatch
    implements UIModel<PlayerOfMatchApiDto> {
  const factory PlayerOfMatch({
    final Players? player,
    final Team? team,
    final List<Players>? battingPerformances,
    final List<Players>? bowlingPerformances,
  }) = _PlayerOfMatch;
  const PlayerOfMatch._();

  @override
  PlayerOfMatchApiDto toApiDto() => PlayerOfMatchApiDto(
        player: player?.toApiDto(),
        team: team?.toApiDto(),
        battingPerformances:
            battingPerformances?.map((e) => e.toApiDto()).toList(),
        bowlingPerformances:
            bowlingPerformances?.map((e) => e.toApiDto()).toList(),
      );
}

// @freezed
// class Original with _$Original implements UIModel<OriginalApiDto> {
//   const factory Original() = _Original;
//   const Original._();

//   @override
//   OriginalApiDto toApiDto() => OriginalApiDto();
// }

@freezed
class MostRuns with _$MostRuns implements UIModel<MostRunsApiDto> {
  const factory MostRuns({
    final Players? player,
    final Team? team,
    final int? runsTotal,
  }) = _MostRuns;
  const MostRuns._();

  @override
  MostRunsApiDto toApiDto() => MostRunsApiDto(
        player: player?.toApiDto(),
        team: team?.toApiDto(),
        runsTotal: runsTotal,
      );
}

@freezed
class MostWickets with _$MostWickets implements UIModel<MostWicketsApiDto> {
  const factory MostWickets({
    final Players? player,
    final Team? team,
    final int? wicketsTotal,
  }) = _MostWickets;
  const MostWickets._();

  @override
  MostWicketsApiDto toApiDto() => MostWicketsApiDto(
        player: player?.toApiDto(),
        team: team?.toApiDto(),
        wicketsTotal: wicketsTotal,
      );
}

@freezed
class ProfilePicture
    with _$ProfilePicture
    implements UIModel<ProfilePictureApiDto> {
  const factory ProfilePicture({
    final String? name,
    final String? alternativeText,
    final String? caption,
    final Original? original,
    final Original? small,
    final Original? medium,
    final Original? large,
  }) = _ProfilePicture;
  const ProfilePicture._();

  @override
  ProfilePictureApiDto toApiDto() => ProfilePictureApiDto(
        name: name,
        alternativeText: alternativeText,
        caption: caption,
        original: original?.toApiDto(),
        small: small?.toApiDto(),
        medium: medium?.toApiDto(),
        large: large?.toApiDto(),
      );
}

@freezed
class Team with _$Team implements UIModel<TeamApiDto> {
  const factory Team({
    final String? teamId,
    final String? name,
    final String? shortName,
    final String? primaryColour,
    final String? secondaryColour,
    final ProfilePicture? logo,
  }) = _Team;
  const Team._();

  @override
  TeamApiDto toApiDto() => TeamApiDto(
        teamId: teamId,
        name: name,
        shortName: shortName,
        primaryColour: primaryColour,
        secondaryColour: secondaryColour,
        logo: logo?.toApiDto(),
      );
}

@freezed
class InningsBalls with _$InningsBalls implements UIModel<InningsBallsApiDto> {
  const factory InningsBalls({
    final String? inningsId,
    final String? battingTeamId,
    final String? bowlingTeamId,
    final int? teamInningsNumber,
    final int? matchInningsNumber,
    final String? status,
    final bool? followingOn,
    final bool? isSuperOver,
    final String? reasonForClose,
    final List<Balls>? balls,
  }) = _InningsBalls;
  const InningsBalls._();

  @override
  InningsBallsApiDto toApiDto() => InningsBallsApiDto(
        inningsId: inningsId,
        battingTeamId: battingTeamId,
        bowlingTeamId: bowlingTeamId,
        teamInningsNumber: teamInningsNumber,
        matchInningsNumber: matchInningsNumber,
        status: status,
        followingOn: followingOn,
        isSuperOver: isSuperOver,
        reasonForClose: reasonForClose,
        balls: balls?.map((e) => e.toApiDto()).toList(),
      );
}

@freezed
class Balls with _$Balls implements UIModel<BallsApiDto> {
  const factory Balls({
    final int? ballNumber,
    final int? ballDisplayNumber,
    final String? shortDescription,
    final int? runsBat,
    final int? runsExtra,
    final int? overNumber,
    final bool? freeHit,
    final bool? endOfOver,
    final String? description,
    final Bowler? bowler,
    final Bowler? batter,
    final InningsProgressiveScore? inningsProgressiveScore,
  }) = _Balls;
  const Balls._();

  @override
  BallsApiDto toApiDto() => BallsApiDto(
        ballNumber: ballNumber,
        ballDisplayNumber: ballDisplayNumber,
        shortDescription: shortDescription,
        runsBat: runsBat,
        runsExtra: runsExtra,
        overNumber: overNumber,
        freeHit: freeHit,
        endOfOver: endOfOver,
        description: description,
        bowler: bowler?.toApiDto(),
        batter: batter?.toApiDto(),
        inningsProgressiveScore: inningsProgressiveScore?.toApiDto(),
      );
}

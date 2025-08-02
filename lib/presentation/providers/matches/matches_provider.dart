import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/configs/app_configuration.dart';
import '../../../data/models/request_body/matches_req_body.dart';
import '../../../data/models/result/data_state.dart';
import '../../../domain/enums/category.dart';
import '../../../domain/enums/match_status.dart';
import '../../../domain/models/match_details/match_details.dart';
import '../../../domain/states/commentary_state.dart';
import '../../../domain/states/competitions_state.dart';
import '../../../domain/states/match_details_state.dart';
import '../../../domain/states/matches_state.dart';
import '../../../domain/states/score_card_state.dart';
import '../../../domain/usecases/matches/matches_usecases.dart';
import '../competitions/competitions_provider.dart';
import '../home/home_provider.dart';

part 'matches_provider.g.dart';

@riverpod
class MatchesNotifier extends _$MatchesNotifier {
  late final GetMatches _getMatches = ref.watch(getMatchesUseCaseProvider);
  @override
  MatchesState build() {
    return const MatchesStateInitial();
  }

  Future<void> getMatches({String? teamId, String? venueId}) async {
    state = const MatchesStateLoading();
    var dataState = await _getMatches(
      MatchParams(
        clientKey:
            ref.watch(selectedCategoryNotifierProvider) == CategoryType.cpl
                ? AppConfiguration.clientKey
                : AppConfiguration.wcplClientKey,
        matchesReqbody: MatchesReqbody(
          teamId: teamId,
          venueId: venueId,
          competetions: ref.read(competitionsNotifierProvider).competitionId,
        ),
      ),
    );
    switch (dataState) {
      case DataStateSuccess<List<MatchDetails>>(data: var matchesData):
        List<MatchDetails> completedMatches = matchesData
            .where((e) => e.status == MatchStatus.completed.val)
            .toList();
        List<MatchDetails> upcomingMatches = matchesData
            .where((e) =>
                e.status == MatchStatus.upcoming.val ||
                e.status == MatchStatus.live.val)
            .toList();
        List<MatchDetails> liveMatches =
            matchesData.where((e) => e.status == MatchStatus.live.val).toList();
        state = MatchesStateLoaded(
            matchData: matchesData,
            completedMatches: completedMatches,
            upcomingMatches: upcomingMatches,
            liveMatches: liveMatches);
      case DataStateError<List<MatchDetails>>(ex: var ex):
        state = MatchesStateError(ex);
    }
  }
}

@riverpod
class HomeMatchesNotifier extends _$HomeMatchesNotifier {
  List<MatchDetails> _matchData = [];
  List<MatchDetails> _liveMatches = [];
  late final GetMatches _getMatches = ref.watch(getMatchesUseCaseProvider);
  @override
  MatchesState build() {
    return const MatchesStateInitial();
  }

  Future<void> getHomeMatches(
      {bool isRefresh = false, String? competitionId}) async {
    state = !isRefresh
        ? const MatchesStateLoading()
        : state = MatchesStateLoaded(
            matchData: _matchData,
            completedMatches: const [],
            upcomingMatches: const [],
            liveMatches: _liveMatches);
    var dataState = await _getMatches(
      MatchParams(
        clientKey:
            ref.watch(selectedCategoryNotifierProvider) == CategoryType.cpl
                ? AppConfiguration.clientKey
                : AppConfiguration.wcplClientKey,
        matchesReqbody: MatchesReqbody(
          teamId: null,
          venueId: null,
          competetions: ref.read(competitionsNotifierProvider).competitionId,
        ),
      ),
    );
    switch (dataState) {
      case DataStateSuccess<List<MatchDetails>>(data: var matchesData):
        _matchData = matchesData;
        _liveMatches = matchesData
            .where((e) =>
                e.status == MatchStatus.live.val ||
                e.status == MatchStatus.upcoming.val)
            .toList();
        state = MatchesStateLoaded(
            matchData: matchesData,
            completedMatches: const [],
            upcomingMatches: const [],
            liveMatches: _liveMatches);
      case DataStateError<List<MatchDetails>>(ex: var ex):
        state = MatchesStateError(ex);
    }
  }
}

@riverpod
class CommentaryExpansionNotifier extends _$CommentaryExpansionNotifier {
  @override
  bool build(int index) {
    return (index == 0) ? false : true;
  }

  Future<void> toggle() async {
    state = !state;
  }
}

@riverpod
class MatchDetailsNotifier extends _$MatchDetailsNotifier {
  MatchDetails _matchDetails = const MatchDetails();

  late final GetMatchDetails _getMatchDetails =
      ref.watch(getMatchDetailsUseCaseProvider);
  @override
  MatchDetailState build() {
    return const MatchDetailStateInitial();
  }

  Future<void> getMatchDetails(String matchId, {bool isRefresh = false}) async {
    state = !isRefresh
        ? const MatchDetailStateLoading()
        : MatchDetailStateLoaded(matchData: _matchDetails);
    var dataState = await _getMatchDetails(MatchDetailsParams(
        clientKey:
            ref.watch(selectedCategoryNotifierProvider) == CategoryType.cpl
                ? AppConfiguration.clientKey
                : AppConfiguration.wcplClientKey,
        matchId: matchId));
    switch (dataState) {
      case DataStateSuccess<MatchDetails>(data: var matchData):
        _matchDetails = matchData;
        state = MatchDetailStateLoaded(matchData: matchData);
      case DataStateError<MatchDetails>(ex: var ex):
        state = MatchDetailStateError(ex);
    }
  }

  getPlayerRole(Players player) {
    var role = "";
    if (player.captain ?? false) {
      if (role == "") role += "(C";
    }
    if (player.wicketKeeper ?? false) {
      if (role == "") {
        role += "(WK";
      } else {
        role += ", WK";
      }
    }
    if (player.substitute ?? false) {
      if (role == "") {
        role += "(Sub";
      } else {
        role += ", Sub";
      }
    }

    if (player.viceCaptain ?? false) {
      if (role == "") {
        role += "(VC";
      } else {
        role += ", VC";
      }
    }

    return role != "" ? ("$role)") : role;
  }

  getSkill(Players? player) {
    var skill = "";
    if (player == null) return "";
    if (((player.battingHand != null) && player.battingHand!.isNotEmpty) &&
        ((player.bowlingArm != null) && player.bowlingArm!.isNotEmpty)) {
      skill += "All Rounder";
    } else if (((player.battingHand != null) &&
        player.battingHand!.isNotEmpty)) {
      skill += "BAT";
    } else if (((player.bowlingArm != null) && player.bowlingArm!.isNotEmpty)) {
      skill += "BOWL";
    }
    return skill;
  }

  getPlayerBattingDescription(Players? player) {
    var skill = "";
    if (player == null) return "";
    if (player.primaryThrowingArm == "Right") {
      skill += "Right-Handed";
    } else {
      skill += "Left-Handed";
    }
    return skill;
  }

  getPlayerOfTheMatch(MatchDetails? matchDetails) {
    if (matchDetails != null &&
        matchDetails.topPerformers != null &&
        matchDetails.topPerformers!.playerOfMatch != null) {
      return matchDetails.topPerformers!.playerOfMatch;
    }
    return null;
  }

  getPlayerOfMostRuns(MatchDetails? matchDetails) {
    if (matchDetails != null &&
        matchDetails.topPerformers != null &&
        matchDetails.topPerformers!.mostRuns != null &&
        matchDetails.topPerformers!.mostRuns?.player != null) {
      return matchDetails.topPerformers!.mostRuns!;
    }
    return null;
  }

  getPlayerOfMostWickets(MatchDetails? matchDetails) {
    if (matchDetails != null &&
        matchDetails.topPerformers != null &&
        matchDetails.topPerformers!.mostWickets != null &&
        matchDetails.topPerformers!.mostWickets?.player != null) {
      return matchDetails.topPerformers!.mostWickets;
    }
    return null;
  }

  getFirstTeamScore(MatchDetails? matchDetails) {
    if (matchDetails == null) return null;
    return matchDetails.inningsScores
        ?.where((element) =>
            element.battingTeamId == matchDetails.teams?.first.teamId)
        .firstWhere((element) => element.progressiveScores != null,
            orElse: () => const InningsScores())
        .progressiveScores;
  }

  getSecondTeamScore(MatchDetails? matchDetails) {
    if (matchDetails == null) return null;
    return matchDetails.inningsScores
        ?.where((element) =>
            element.battingTeamId == matchDetails.teams?.last.teamId)
        .firstWhere((element) => element.progressiveScores != null,
            orElse: () => const InningsScores())
        .progressiveScores;
  }

  getFirstInningsId() {
    final MatchDetails? matchDetails = state.matchDetails;
    if (matchDetails == null) return null;
    return matchDetails.inningsScores
            ?.where((element) =>
                element.battingTeamId == matchDetails.teams?.first.teamId)
            .firstWhere((element) => element.progressiveScores != null,
                orElse: () => const InningsScores())
            .inningsId ??
        "";
  }

  getSecondInningsId() {
    final MatchDetails? matchDetails = state.matchDetails;
    if (matchDetails == null) return null;
    return matchDetails.inningsScores
            ?.where((element) =>
                element.battingTeamId == matchDetails.teams?.last.teamId)
            .firstWhere((element) => element.progressiveScores != null,
                orElse: () => const InningsScores())
            .inningsId ??
        "";
  }
}

@Riverpod(keepAlive: true)
class ScoreCardNotifier extends _$ScoreCardNotifier {
  late final GetScoreCard _getScoreCard =
      ref.watch(getScoreCardUseCaseProvider);
  @override
  ScoreCardState build() {
    return const ScoreCardStateInitial();
  }

  Future<void> getScoreCard(String matchId) async {
    state = const ScoreCardStateLoading();
    var dataState = await _getScoreCard(MatchDetailsParams(
        clientKey:
            ref.watch(selectedCategoryNotifierProvider) == CategoryType.cpl
                ? AppConfiguration.clientKey
                : AppConfiguration.wcplClientKey,
        matchId: matchId));
    switch (dataState) {
      case DataStateSuccess<MatchDetails>(data: var matchData):
        state = ScoreCardStateLoaded(scoreCard: matchData);
      case DataStateError<MatchDetails>(ex: var ex):
        state = ScoreCardStateError(ex);
    }
  }
}

@Riverpod(keepAlive: true)
class CommentaryNotifier extends _$CommentaryNotifier {
  List<List<Balls>> _commentary = [];

  late final GetCommentary _getCommentary =
      ref.watch(getCommentaryUseCaseProvider);
  @override
  CommentaryState build(String inningsId) {
    return const CommentaryStateInitial();
  }

  Future<void> getCommentary(String matchId, {bool isRefresh = false}) async {
    state = !isRefresh
        ? const CommentaryStateLoading()
        : CommentaryStateLoaded(commentary: _commentary);
    var dataState = await _getCommentary(CommentaryParams(
        clientKey:
            ref.watch(selectedCategoryNotifierProvider) == CategoryType.cpl
                ? AppConfiguration.clientKey
                : AppConfiguration.wcplClientKey,
        matchId: matchId,
        inningsId: inningsId));
    switch (dataState) {
      case DataStateSuccess<MatchDetails>(data: var matchData):
        final List<Balls> recentBalls = matchData.inningsBalls
                ?.firstWhere((element) => element.inningsId == inningsId)
                .balls ??
            [];
        List<List<Balls>> sortedDeliveries = [];
        if (recentBalls.isNotEmpty) {
          // Group deliveries by over
          var groupedRecentBalls = <int, List<Balls>>{};
          for (var recentBall in recentBalls) {
            if (recentBall.overNumber != null) {}
            groupedRecentBalls
                .putIfAbsent(recentBall.overNumber!, () => [])
                .add(recentBall);
          }

          // Sort each group by ball number
          for (var over in groupedRecentBalls.keys) {
            if (groupedRecentBalls[over] != null) {
              groupedRecentBalls[over]!.sort((a, b) {
                if (a.ballNumber != null && b.ballNumber != null) {
                  return b.ballNumber!.compareTo(a.ballNumber!);
                }
                return 0;
              });
            }
          }

          // Sort the keys (overs) in descending order and create a sorted list of lists
          var sortedOverKeys = groupedRecentBalls.keys.toList()
            ..sort(
              (a, b) => b.compareTo(a),
            );

          if (sortedOverKeys.isNotEmpty) {
            sortedDeliveries = sortedOverKeys
                .map((over) =>
                    (groupedRecentBalls[over] ?? groupedRecentBalls[0])!)
                .toList();
          }
        }
        _commentary = sortedDeliveries;
        state = CommentaryStateLoaded(commentary: sortedDeliveries);
      case DataStateError<MatchDetails>(ex: var ex):
        state = CommentaryStateError(ex);
    }
  }
}

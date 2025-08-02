import 'package:flutter/foundation.dart';

import '../../core/utils/errors/app_exception.dart';
import '../models/players/player.dart';

@immutable
sealed class PlayersState {
  const PlayersState();
}

final class PlayersStateInitial extends PlayersState {
  const PlayersStateInitial();
}

final class PlayersStateLoading extends PlayersState {
  const PlayersStateLoading();
}

final class PlayersStateLoaded extends PlayersState {
  const PlayersStateLoaded({required this.players});
  final List<PlayerData> players;
}

final class PlayersStateError extends PlayersState {
  const PlayersStateError({required this.ex});
  final AppException ex;
}

extension PlayersStateExtention on PlayersState {
  PlayerData? get captain => switch (this) {
        PlayersStateInitial() => null,
        PlayersStateLoading() => null,
        PlayersStateLoaded(players: List<PlayerData> players) =>
          players.firstWhere(
            (element) =>
                element.acf?.playerDistinction?.contains("Captain") ?? false,
            orElse: () => const PlayerData(),
          ),
        PlayersStateError() => null,
      };
}

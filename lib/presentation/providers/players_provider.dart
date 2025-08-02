import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/result/data_state.dart';
import '../../domain/models/players/player.dart';
import '../../domain/states/players_state.dart';
import '../../domain/usecases/teams/teams_usecases.dart';

part 'players_provider.g.dart';

@riverpod
class PlayersNotifier extends _$PlayersNotifier {
  late final GetPlayers _getPlayers = ref.watch(getPlayersUseCaseProvider);

  @override
  PlayersState build() {
    return const PlayersStateInitial();
  }

  Future<void> getPlayers(int teamId) async {
    state = const PlayersStateLoading();
    var respo = await _getPlayers(teamId);
    switch (respo) {
      case DataStateSuccess<List<PlayerData>>(data: List<PlayerData> data):
        var players =
            data.where((player) => (player.acf?.team?.iD == teamId)).toList();
        state = PlayersStateLoaded(players: players);
      case DataStateError<List<PlayerData>>(ex: var ex):
        state = PlayersStateError(ex: ex);
    }
  }

  getPlayerPosition(PlayerData player) {
    var data = player.acf?.playerPosition ?? [];
    if (data.isNotEmpty) {
      String isWK = data.firstWhere(
        (element) => element == "Wicketkeeper",
        orElse: () => "",
      );
      if (isWK.isNotEmpty) {
        return '${data[0]} & WK';
      }
      return data[0];
    }

    return '';
  }
}

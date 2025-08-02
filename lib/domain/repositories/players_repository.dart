import '../../data/models/result/data_state.dart';
import '../models/players/player.dart';

abstract interface class PlayerRepository {
  Future<DataState<List<PlayerData>>> players(int teamId);
}

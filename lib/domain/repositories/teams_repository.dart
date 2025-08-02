import '../../data/models/result/data_state.dart';
import '../enums/team_type.dart';
import '../models/teams/teams.dart';

abstract interface class TeamsRepository {
  Future<DataState<List<TeamsData>>> teams(TeamType teamType);
}

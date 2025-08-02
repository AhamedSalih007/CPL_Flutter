import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/models/result/data_state.dart';
import '../../domain/enums/category.dart';
import '../../domain/enums/team_type.dart';
import '../../domain/models/teams/teams.dart';
import '../../domain/states/teams_state.dart';
import '../../domain/usecases/teams/teams_usecases.dart';
import 'home/home_provider.dart';

part 'teams_provider.g.dart';

@Riverpod(keepAlive: true)
class TeamsNotifier extends _$TeamsNotifier {
  late final GetTeams _getTeams = ref.watch(getTeamsUseCaseProvider);

  @override
  TeamsState build() {
    return const TeamsStateInitial();
  }

  Future<void> getTeams() async {
    state = const TeamsStateLoading();
    var respo = await _getTeams(
        ref.watch(selectedCategoryNotifierProvider) == CategoryType.cpl
            ? TeamType.men
            : TeamType.women);
    switch (respo) {
      case DataStateSuccess<List<TeamsData>>(data: List<TeamsData> data):
        state = TeamsStateLoaded(teams: data);
      case DataStateError<List<TeamsData>>(ex: var ex):
        state = TeamsStateError(ex: ex);
    }
  }
}

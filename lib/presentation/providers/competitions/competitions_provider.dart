import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/configs/app_configuration.dart';
import '../../../data/models/result/data_state.dart';
import '../../../domain/enums/category.dart';
import '../../../domain/models/competitions/competitions.dart';
import '../../../domain/states/competitions_state.dart';
import '../../../domain/usecases/competitions/competitions_usecases.dart';
import '../home/home_provider.dart';

part 'competitions_provider.g.dart';

@Riverpod(keepAlive: true)
class CompetitionsNotifier extends _$CompetitionsNotifier {
  late final GetCompetitions _getCompetitions =
      ref.watch(getCompetitionsUseCaseProvider);

  @override
  CompetitionState build() {
    return const CompetitionStateInitial();
  }

  Future<void> getCompetitions() async {
    state = const CompetitionStateLoading();
    var dataState = await _getCompetitions(
        ref.watch(selectedCategoryNotifierProvider) == CategoryType.cpl
            ? AppConfiguration.clientKey
            : AppConfiguration.wcplClientKey);
    switch (dataState) {
      case DataStateSuccess<List<CompetitionData>>(data: var competitionData):
        state = CompetitionStateLoaded(competitionData: competitionData);
      case DataStateError<List<CompetitionData>>(ex: var ex):
        state = CompetitionStateError(ex);
    }
  }
}

@Riverpod(keepAlive: true)
class TeamFilterNotifier extends _$TeamFilterNotifier {
  @override
  CompetitionTeams? build() {
    return null;
  }

  void update(CompetitionTeams? team) async {
    state = team;
  }
}

@Riverpod(keepAlive: true)
class VenueFilterNotifier extends _$VenueFilterNotifier {
  @override
  Venues? build() {
    return null;
  }

  void update(Venues? venue) async {
    state = venue;
  }
}

@Riverpod(keepAlive: true)
class YeaFilterNotifier extends _$YeaFilterNotifier {
  @override
  String? build() {
    return "2024";
  }

  void update(String? year) async {
    state = year;
  }
}

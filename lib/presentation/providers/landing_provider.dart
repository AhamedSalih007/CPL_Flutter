import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/enums/match_tab_type.dart';
import '../../domain/enums/tab_type.dart';
part 'landing_provider.g.dart';

@Riverpod(keepAlive: true)
class TabIndexNotifier extends _$TabIndexNotifier {
  @override
  TabType build() {
    return TabType.homeTab;
  }

  void updateTo(TabType tab) {
    state = tab;
  }
}

@Riverpod(keepAlive: true)
class NotificationTapNotifier extends _$NotificationTapNotifier {
  @override
  bool build() {
    return false;
  }

  void updateTo(bool isTapped) {
    state = isTapped;
  }
}

@Riverpod(keepAlive: true)
class MatchTabIndexNotifier extends _$MatchTabIndexNotifier {
  @override
  MatchesTabType build() {
    return MatchesTabType.upcomingMatches;
  }

  void updateTo(MatchesTabType tab) {
    state = tab;
  }
}

@riverpod
class CarousalIndexNotifier extends _$CarousalIndexNotifier {
  @override
  int build(TabType tabType) {
    return 0;
  }

  void updateTo(int index) {
    state = index;
  }
}

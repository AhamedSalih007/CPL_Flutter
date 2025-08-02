import '../models/match_details/match_details.dart';

enum DismissalType {
  caught("Caught"),
  lbw("LBW"),
  bowled("Bowled"),
  stumped("Stumped"),
  runOut("Run Out"),
  hitWicket("Hit Wicket"),
  retiredHurt("Retired Hurt"),
  hitTwice("Hit Twice"),
  timedOut("Timed Out"),
  handledBall("Handled Ball"),
  obstructingField("Obstructing Field"),
  retired("Retired"),
  absent("Absent"),
  didNotBat("Did Not Bat"),
  notOut("Not Out");

  final String val;

  const DismissalType(this.val);
}

extension DismissalTypeExtension on DismissalType {
  String getDescription(Dismissal player) {
    switch (this) {
      case DismissalType.bowled:
        return "b ${player.bowler?.cardNameF}";
      case DismissalType.caught:
        return "c ${(player.fielders?.isNotEmpty ?? false) ? player.fielders![0].cardNameF : "&"} b ${player.bowler?.cardNameF}";
      case DismissalType.lbw:
        return "lbw ${player.bowler?.cardNameF}";
      case DismissalType.stumped:
        return "stmp ${(player.fielders?.isNotEmpty ?? false) ? player.fielders![0].cardNameF : ""} b ${player.bowler?.cardNameF}";
      case DismissalType.runOut:
        return "runout ${(player.fielders?.isNotEmpty ?? false) ? player.fielders![0].cardNameF : ""}";
      case DismissalType.hitWicket:
        return "hit wicket";
      case DismissalType.retiredHurt:
        return "retired hurt";
      case DismissalType.hitTwice:
        return "hit twice";
      case DismissalType.timedOut:
        return "time out";
      case DismissalType.handledBall:
        return "handled ball";
      case DismissalType.obstructingField:
        return "obstructing field";
      case DismissalType.retired:
        return "retired";
      case DismissalType.absent:
        return "absent";
      case DismissalType.didNotBat:
        return "did not bat";
      case DismissalType.notOut:
        return "not out";
      default:
        return "";
    }
  }
}

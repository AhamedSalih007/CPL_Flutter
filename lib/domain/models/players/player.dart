import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../core/utils/mappers/ui_model.dart';
import '../../../data/models/api/players/player_api_dto.dart';
import '../news/news.dart';

part 'player.freezed.dart';

@freezed
class PlayerData with _$PlayerData implements UIModel<PlayerDataApiDto> {
  const factory PlayerData({
    int? id,
    String? date,
    String? dateGmt,
    Guid? guid,
    String? modified,
    String? modifiedGmt,
    String? slug,
    String? status,
    String? type,
    String? link,
    Guid? title,
    String? template,
    List<int>? categories,
    PlayerAcfApiDto? acf,
    //Links? lLinks,
  }) = _PlayerData;
  const PlayerData._();

  @override
  PlayerDataApiDto toApiDto() => const PlayerDataApiDto(
      //required field here
      );
}

@freezed
class PlayerAcf with _$PlayerAcf implements UIModel<PlayerAcfApiDto> {
  const factory PlayerAcf({
    String? fullName,
    String? shortName,
    String? dob,
    String? photo,
    PlayerTeam? team,
    String? bio,
    String? country,
    List<String>? playerPosition,
    //List<Null>? playerSubPosition,
    String? playerType,
    List<String>? playerDistinction,
    String? twitter,
    String? instagram,
    String? crickinfo,
    String? crickinfoUrl,
  }) = _PlayerAcf;
  const PlayerAcf._();

  @override
  PlayerAcfApiDto toApiDto() => const PlayerAcfApiDto(
      //required field here
      );
}

@freezed
class PlayerTeam with _$PlayerTeam implements UIModel<PlayerTeamApiDto> {
  const factory PlayerTeam({
    int? iD,
    String? postAuthor,
    String? postDate,
    String? postDateGmt,
    String? postContent,
    String? postTitle,
    String? postExcerpt,
    String? postStatus,
    String? commentStatus,
    String? pingStatus,
    String? postPassword,
    String? postName,
    String? toPing,
    String? pinged,
    String? postModified,
    String? postModifiedGmt,
    String? postContentFiltered,
    int? postParent,
    String? guid,
    int? menuOrder,
    String? postType,
    String? postMimeType,
    String? commentCount,
    String? filter,
  }) = _PlayerTeam;
  const PlayerTeam._();

  @override
  PlayerTeamApiDto toApiDto() => const PlayerTeamApiDto(
      //required field here
      );
}

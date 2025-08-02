import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/utils/mappers/api_dto.dart';
import '../../../../domain/models/players/player.dart';
import '../news/news_api_dto.dart';

part 'player_api_dto.freezed.dart';
part 'player_api_dto.g.dart';

@freezed
class PlayerDataApiDto with _$PlayerDataApiDto implements ApiDto<PlayerData> {
  const factory PlayerDataApiDto({
    int? id,
    String? date,
    String? dateGmt,
    GuidApiDto? guid,
    String? modified,
    String? modifiedGmt,
    String? slug,
    String? status,
    String? type,
    String? link,
    GuidApiDto? title,
    String? template,
    List<int>? categories,
    PlayerAcfApiDto? acf,
    //Links? lLinks,
  }) = _PlayerDataApiDto;
  const PlayerDataApiDto._();

  factory PlayerDataApiDto.fromJson(Map<String, dynamic> json) =>
      _$PlayerDataApiDtoFromJson(json);

  @override
  PlayerData toModel() => PlayerData(
        id: id,
        title: title?.toModel(),
        acf: acf,
      );
}

@freezed
class PlayerAcfApiDto with _$PlayerAcfApiDto implements ApiDto<PlayerAcf> {
  const factory PlayerAcfApiDto({
    @JsonKey(name: "full_name") String? fullName,
    @JsonKey(name: "short_name") String? shortName,
    String? dob,
    String? photo,
    PlayerTeamApiDto? team,
    String? bio,
    String? country,
    @JsonKey(name: "player_position") List<String>? playerPosition,
    //List<Null>? playerSubPosition,
    String? playerType,
    @JsonKey(name: "player_distinction") List<String>? playerDistinction,
    String? twitter,
    String? instagram,
    String? crickinfo,
    @JsonKey(name: "crickinfo_url") String? crickinfoUrl,
  }) = _PlayerAcfApiDto;
  const PlayerAcfApiDto._();

  factory PlayerAcfApiDto.fromJson(Map<String, dynamic> json) =>
      _$PlayerAcfApiDtoFromJson(json);

  @override
  PlayerAcf toModel() => PlayerAcf(
      fullName: fullName,
      bio: bio,
      country: country,
      crickinfo: crickinfo,
      crickinfoUrl: crickinfoUrl,
      dob: dob,
      instagram: instagram,
      photo: photo,
      playerPosition: playerPosition,
      playerType: playerType,
      shortName: shortName,
      team: team?.toModel(),
      twitter: twitter,
      playerDistinction: playerDistinction);
}

@freezed
class PlayerTeamApiDto with _$PlayerTeamApiDto implements ApiDto<PlayerTeam> {
  const factory PlayerTeamApiDto({
    @JsonKey(name: "ID") int? iD,
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
  }) = _PlayerTeamApiDto;
  const PlayerTeamApiDto._();

  factory PlayerTeamApiDto.fromJson(Map<String, dynamic> json) =>
      _$PlayerTeamApiDtoFromJson(json);

  @override
  PlayerTeam toModel() => PlayerTeam(
      iD: iD,
      commentCount: commentCount,
      commentStatus: commentStatus,
      filter: filter,
      guid: guid,
      menuOrder: menuOrder,
      pingStatus: pingStatus,
      pinged: pinged,
      postAuthor: postAuthor,
      postContent: postContent,
      postContentFiltered: postContentFiltered,
      postDate: postDate,
      postDateGmt: postDateGmt,
      postExcerpt: postExcerpt,
      postMimeType: postMimeType,
      postModified: postModified,
      postModifiedGmt: postModifiedGmt,
      postName: postName,
      postParent: postParent,
      postPassword: postPassword,
      postStatus: postStatus,
      postTitle: postTitle,
      postType: postType,
      toPing: toPing);
}

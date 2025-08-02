import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/utils/mappers/api_dto.dart';
import '../../../../domain/models/sponsors/sponsors.dart';

part 'sponsers_api_dto.freezed.dart';
part 'sponsers_api_dto.g.dart';

@freezed
class SponsorsDataApiDto
    with _$SponsorsDataApiDto
    implements ApiDto<SponsorsData> {
  const factory SponsorsDataApiDto({
    int? id,
    String? date,
    List<int>? categories,
    SponsorsAcfApiDto? acf,
    String? slug,
    String? type,
  }) = _SponsorsDataApiDto;
  const SponsorsDataApiDto._();

  factory SponsorsDataApiDto.fromJson(Map<String, dynamic> json) =>
      _$SponsorsDataApiDtoFromJson(json);

  @override
  SponsorsData toModel() => SponsorsData(
        id: id,
        acf: acf?.toModel(),
        categories: categories,
        date: date,
        slug: slug,
        type: type,
      );
}

@freezed
class SponsorsAcfApiDto
    with _$SponsorsAcfApiDto
    implements ApiDto<SponsorsAcf> {
  const factory SponsorsAcfApiDto({
    @JsonKey(name: "Sponsors") List<SponsorsApiDto>? sponsors,
  }) = _SponsorsAcfApiDto;
  const SponsorsAcfApiDto._();

  factory SponsorsAcfApiDto.fromJson(Map<String, dynamic> json) =>
      _$SponsorsAcfApiDtoFromJson(json);

  @override
  SponsorsAcf toModel() => SponsorsAcf(
        sponsors: sponsors?.map((e) => e.toModel()).toList(),
      );
}

@freezed
class SponsorsApiDto with _$SponsorsApiDto implements ApiDto<Sponsors> {
  const factory SponsorsApiDto({
    @JsonKey(name: "sponsor_logo") String? sponsorLogo,
    @JsonKey(name: "sponsor_link") String? sponsorLink,
  }) = _SponsorsApiDto;
  const SponsorsApiDto._();

  factory SponsorsApiDto.fromJson(Map<String, dynamic> json) =>
      _$SponsorsApiDtoFromJson(json);

  @override
  Sponsors toModel() => Sponsors(
        sponsorLogo: sponsorLogo,
        sponsorLink: sponsorLink,
      );
}

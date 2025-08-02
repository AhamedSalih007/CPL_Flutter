import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../core/utils/mappers/ui_model.dart';
import '../../../data/models/api/sponsors/sponsers_api_dto.dart';

part 'sponsors.freezed.dart';

@freezed
class SponsorsData with _$SponsorsData implements UIModel<SponsorsDataApiDto> {
  const factory SponsorsData({
    int? id,
    String? date,
    List<int>? categories,
    SponsorsAcf? acf,
    String? slug,
    String? type,
  }) = _SponsorsData;
  const SponsorsData._();

  @override
  SponsorsDataApiDto toApiDto() => SponsorsDataApiDto(
        id: id,
        acf: acf?.toApiDto(),
        categories: categories,
        date: date,
        slug: slug,
        type: type,
      );
}

@freezed
class SponsorsAcf with _$SponsorsAcf implements UIModel<SponsorsAcfApiDto> {
  const factory SponsorsAcf({
    List<Sponsors>? sponsors,
  }) = _SponsorsAcf;
  const SponsorsAcf._();

  @override
  SponsorsAcfApiDto toApiDto() => SponsorsAcfApiDto(
        sponsors: sponsors?.map((e) => e.toApiDto()).toList(),
      );
}

@freezed
class Sponsors with _$Sponsors implements UIModel<SponsorsApiDto> {
  const factory Sponsors({
    String? sponsorLogo,
    String? sponsorLink,
  }) = _Sponsors;
  const Sponsors._();

  @override
  SponsorsApiDto toApiDto() => SponsorsApiDto(
        sponsorLogo: sponsorLogo,
        sponsorLink: sponsorLink,
      );
}

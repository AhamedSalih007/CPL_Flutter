import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/utils/mappers/api_dto.dart';
import '../../../../domain/models/partners/partners.dart';

part 'partners_api_dto.freezed.dart';
part 'partners_api_dto.g.dart';

@freezed
class PartnersDataApiDto
    with _$PartnersDataApiDto
    implements ApiDto<PartnersData> {
  const factory PartnersDataApiDto({
    int? id,
    String? date,
    List<int>? categories,
    PartnersAcfApiDto? acf,
    String? slug,
    String? type,
  }) = _PartnersDataApiDto;
  const PartnersDataApiDto._();

  factory PartnersDataApiDto.fromJson(Map<String, dynamic> json) =>
      _$PartnersDataApiDtoFromJson(json);

  @override
  PartnersData toModel() => PartnersData(
      id: id,
      acf: acf?.toModel(),
      categories: categories,
      date: date,
      slug: slug,
      type: type);
}

@freezed
class PartnersAcfApiDto
    with _$PartnersAcfApiDto
    implements ApiDto<PartnersAcf> {
  const factory PartnersAcfApiDto({
    @JsonKey(name: "Partners") List<PartnersApiDto>? partners,
  }) = _PartnersAcfApiDto;
  const PartnersAcfApiDto._();

  factory PartnersAcfApiDto.fromJson(Map<String, dynamic> json) =>
      _$PartnersAcfApiDtoFromJson(json);

  @override
  PartnersAcf toModel() => PartnersAcf(
        partners: partners?.map((e) => e.toModel()).toList(),
      );
}

@freezed
class PartnersApiDto with _$PartnersApiDto implements ApiDto<Partners> {
  const factory PartnersApiDto({
    @JsonKey(name: "partner_logo") String? partnerLogo,
    @JsonKey(name: "partner_link") String? partnerLink,
  }) = _PartnersApiDto;
  const PartnersApiDto._();

  factory PartnersApiDto.fromJson(Map<String, dynamic> json) =>
      _$PartnersApiDtoFromJson(json);

  @override
  Partners toModel() => Partners(
        partnerLogo: partnerLogo,
        partnerLink: partnerLink,
      );
}

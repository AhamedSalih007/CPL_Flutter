import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../core/utils/mappers/ui_model.dart';
import '../../../data/models/api/partners/partners_api_dto.dart';

part 'partners.freezed.dart';

@freezed
class PartnersData with _$PartnersData implements UIModel<PartnersDataApiDto> {
  const factory PartnersData({
    int? id,
    String? date,
    List<int>? categories,
    PartnersAcf? acf,
    String? slug,
    String? type,
  }) = _PartnersData;
  const PartnersData._();

  @override
  PartnersDataApiDto toApiDto() => PartnersDataApiDto(
        id: id,
        acf: acf?.toApiDto(),
        categories: categories,
        date: date,
        slug: slug,
        type: type,
      );
}

@freezed
class PartnersAcf with _$PartnersAcf implements UIModel<PartnersAcfApiDto> {
  const factory PartnersAcf({
    List<Partners>? partners,
  }) = _PartnersAcf;
  const PartnersAcf._();

  @override
  PartnersAcfApiDto toApiDto() => PartnersAcfApiDto(
        partners: partners?.map((e) => e.toApiDto()).toList(),
      );
}

@freezed
class Partners with _$Partners implements UIModel<PartnersApiDto> {
  const factory Partners({
    String? partnerLogo,
    String? partnerLink,
  }) = _Partners;
  const Partners._();

  @override
  PartnersApiDto toApiDto() => PartnersApiDto(
        partnerLogo: partnerLogo,
        partnerLink: partnerLink,
      );
}

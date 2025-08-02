import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/utils/mappers/api_dto.dart';
import '../../../../domain/models/marquee_text/marquee_text.dart';

part 'marquee_text_api_dto.freezed.dart';
part 'marquee_text_api_dto.g.dart';

@freezed
class MarqueeTextDataApiDto
    with _$MarqueeTextDataApiDto
    implements ApiDto<MarqueeTextData> {
  const factory MarqueeTextDataApiDto({
    int? id,
    @JsonKey(name: "acf") MarqueeTextAcfApiDto? acf,
  }) = _MarqueeTextDataApiDto;
  const MarqueeTextDataApiDto._();

  factory MarqueeTextDataApiDto.fromJson(Map<String, dynamic> json) =>
      _$MarqueeTextDataApiDtoFromJson(json);

  @override
  MarqueeTextData toModel() => MarqueeTextData(
        acf: acf?.toModel(),
        id: id,
      );
}

@freezed
class MarqueeTextAcfApiDto
    with _$MarqueeTextAcfApiDto
    implements ApiDto<MarqueeTextAcf> {
  const factory MarqueeTextAcfApiDto({
    @JsonKey(name: "marquee_text") List<MarqueeTextApiDto>? marqueeText,
  }) = _MarqueeTextAcfApiDto;
  const MarqueeTextAcfApiDto._();

  factory MarqueeTextAcfApiDto.fromJson(Map<String, dynamic> json) =>
      _$MarqueeTextAcfApiDtoFromJson(json);

  @override
  MarqueeTextAcf toModel() => MarqueeTextAcf(
      marqueeText: marqueeText?.map((e) => e.toModel()).toList());
}

@freezed
class MarqueeTextApiDto
    with _$MarqueeTextApiDto
    implements ApiDto<MarqueeText> {
  const factory MarqueeTextApiDto({
    @JsonKey(name: "marquee_text") String? marqueeText,
  }) = _MarqueeTextApiDto;
  const MarqueeTextApiDto._();

  factory MarqueeTextApiDto.fromJson(Map<String, dynamic> json) =>
      _$MarqueeTextApiDtoFromJson(json);

  @override
  MarqueeText toModel() => MarqueeText(marqueeText: marqueeText);
}

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../core/utils/mappers/ui_model.dart';
import '../../../data/models/api/marquee_text/marquee_text_api_dto.dart';

part 'marquee_text.freezed.dart';

@freezed
class MarqueeTextData
    with _$MarqueeTextData
    implements UIModel<MarqueeTextDataApiDto> {
  const factory MarqueeTextData({int? id, MarqueeTextAcf? acf}) =
      _MarqueeTextData;
  const MarqueeTextData._();

  @override
  MarqueeTextDataApiDto toApiDto() => const MarqueeTextDataApiDto(
      //required field here
      );
}

@freezed
class MarqueeTextAcf
    with _$MarqueeTextAcf
    implements UIModel<MarqueeTextAcfApiDto> {
  const factory MarqueeTextAcf({
    List<MarqueeText>? marqueeText,
  }) = _MarqueeTextAcf;
  const MarqueeTextAcf._();

  @override
  MarqueeTextAcfApiDto toApiDto() => const MarqueeTextAcfApiDto(
      //required field here
      );
}

@freezed
class MarqueeText with _$MarqueeText implements UIModel<MarqueeTextApiDto> {
  const factory MarqueeText({
    String? marqueeText,
  }) = _MarqueeText;
  const MarqueeText._();

  @override
  MarqueeTextApiDto toApiDto() => const MarqueeTextApiDto(
      //required field here
      );
}

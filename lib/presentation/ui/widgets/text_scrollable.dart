import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scroll_loop_auto_scroll/scroll_loop_auto_scroll.dart';

import '../../../core/utils/assets_gen/assets.gen.dart';
import '../../../core/utils/assets_gen/fonts.gen.dart';
import '../../../core/utils/extensions/context_extension.dart';
import '../../../domain/models/marquee_text/marquee_text.dart';
import '../../../domain/states/marquee_text_state.dart';
import '../../providers/marquee_text/marquee_text_provider.dart';
import 'buttons/primary_button.dart';
import 'custom_text.dart';
import 'shimmer/common_shimmer.dart';

class TextScrollableWidget extends ConsumerWidget {
  const TextScrollableWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final marqueeTextState = ref.watch(marqueeNotifierProvider);
    return switch (marqueeTextState) {
      MarqueeTextStateInitial() => const SizedBox(),
      MarqueeTextStateLoading() => Center(
          child: CommonShimmer(height: 40, width: context.screenWidth * 0.9)),
      MarqueeTextStateLoaded(marqueeText: List<MarqueeText> marqueeText) =>
        marqueeText.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ScrollLoopAutoScroll(
                    scrollDirection: Axis.horizontal, //required
                    delay: const Duration(seconds: 2),
                    duration: const Duration(seconds: 50),
                    gap: 0,
                    reverseScroll: false,
                    duplicateChild: 10,
                    enableScrollInput: true,
                    delayAfterScrollInput: const Duration(seconds: 1),
                    child: SizedBox(
                      height: context.screenHeight * 0.04,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: marqueeText.length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Assets.icons.arrow.svg(),
                              ),
                              CustomText.displaySmall(
                                marqueeText[index].marqueeText ?? "",
                                color: context.colorScheme.tertiary,
                                fontWeight: FontWeight.w500,
                                fontFamily: FontFamily.cplt20,
                              ),
                            ],
                          );
                        },
                      ),
                    )),
              )
            : const SizedBox.shrink(),
      MarqueeTextStateError(ex: var _) => Align(
          child: SizedBox(
            width: context.screenWidth * 0.5,
            child: PrimaryButton(
              borderColor: context.colorScheme.tertiary,
              textColor: context.colorScheme.tertiary,
              text: "Try again",
              onPressed: () =>
                  ref.read(marqueeNotifierProvider.notifier).getMarqueeText(),
            ),
          ),
        ),
    };
  }
}

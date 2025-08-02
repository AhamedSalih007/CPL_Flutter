import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../../core/utils/assets_gen/assets.gen.dart';
import '../../../../../../../core/utils/assets_gen/fonts.gen.dart';
import '../../../../../../../core/utils/styles/dimensions/ui_dimensions.dart';
import '../../../../../../../domain/models/social_media/social_media.dart';
import '../../../../../../../domain/states/social_media_state.dart';
import '../../../../../../providers/social_media_links_provider.dart';
import '../../../../../modals/snack_bar/snack_bar_factory.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/error_cards/something_went_wrong_card.dart';
import '../../../../../widgets/shimmer/common_shimmer.dart';
import '../../../../../widgets/shimmer/social_media_shimmer.dart';

class Footer extends ConsumerWidget {
  const Footer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return socialMediaLinks(ref, context);
  }

  Widget socialMediaLinks(WidgetRef ref, BuildContext context) {
    final socialMediaLinksState = ref.watch(socialMediaLinksNotifierProvider);
    return switch (socialMediaLinksState) {
      SocialMediaStateInitial() => const SocialMediaShimmer(),
      SocialMediaStateLoading() => const SocialMediaShimmer(),
      SocialMediaStateLoaded(socialMedia: List<SocialMedia> socialMedia) =>
        socialMedia.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomText.headlineSmall(
                    "FOLLOW US ON",
                    fontFamily: FontFamily.cplt20,
                  ),
                  UIDimensions.verticalSpaceMedium,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...List.generate(
                        socialMedia.length,
                        (index) => Row(
                          children: [
                            InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () async {
                                final Uri url =
                                    Uri.parse(socialMedia[index].url ?? "");
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url);
                                } else {
                                  if (context.mounted) {
                                    SnackbarFactory.showError(
                                        "Can not launch URL");
                                  }
                                }
                              },
                              child: CachedNetworkImage(
                                imageUrl: socialMedia[index].logo ?? "",
                                height: 24,
                                width: 24,
                                fit: BoxFit.fill,
                                placeholder: (context, url) => CommonShimmer(
                                  height: 40,
                                  width: 40,
                                  cornerRadius: UIDimensions.radius(999),
                                ),
                                errorWidget: (context, url, error) {
                                  return Assets.images.errorImage.image(
                                    height: 40,
                                    width: 40,
                                  );
                                },
                              ),
                            ),
                            UIDimensions.horizontalSpaceMedium,
                          ],
                        ),
                      )
                    ],
                  ),
                  UIDimensions.verticalSpaceLarge,
                ],
              )
            : const SizedBox.shrink(),
      SocialMediaStateError() => SomethingWentWrongCard(
          onPressed: () => ref
              .read(socialMediaLinksNotifierProvider.notifier)
              .getSocialMediaLinks(),
        )
    };
  }
}

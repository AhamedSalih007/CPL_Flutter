import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/utils/assets_gen/assets.gen.dart';
import '../../../../core/utils/extensions/context_extension.dart';
import '../../../../core/utils/extensions/string_extensions.dart';
import '../../../../core/utils/styles/dimensions/ui_dimensions.dart';
import '../../../../domain/enums/category.dart';
import '../../../../domain/models/partners/partners.dart';
import '../../../../domain/models/sponsors/sponsors.dart';
import '../../../../domain/states/partners_state.dart';
import '../../../../domain/states/sponsors_state.dart';
import '../../../providers/home/home_provider.dart';
import '../../../providers/partners/partners_provider.dart';
import '../../../providers/sponsors/sponsors_provider.dart';
import '../../modals/snack_bar/snack_bar_factory.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/shimmer/image_place_holder.dart';
import '../../widgets/shimmer/partners_shimmer.dart';
import '../../widgets/shimmer/sponsorship_shimmer.dart';

@RoutePage()
class SponsorsScreen extends ConsumerWidget {
  const SponsorsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBody: false,
      extendBodyBehindAppBar: false,
      body: Center(
        child: Container(
          width: context.screenWidth,
          padding: const EdgeInsets.symmetric(vertical: kToolbarHeight + 20),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    Assets.images.splashBackground.path,
                  ),
                  fit: BoxFit.fill)),
          child: Align(
            alignment: Alignment.center,
            child: RefreshIndicator(
              onRefresh: () {
                return onRefresh(ref);
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    sponsers(ref, context),
                    partners(ref, context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> onRefresh(WidgetRef ref) async {
  ref.read(sponsorsNotifierProvider.notifier).getSponsors();
  ref.read(partnersNotifierProvider.notifier).getPartners();
}

Widget sponsers(WidgetRef ref, BuildContext context) {
  final sponserState = ref.watch(sponsorsNotifierProvider);
  final selectedCategory = ref.watch(selectedCategoryNotifierProvider);
  switch (sponserState) {
    case SponsorsStateInitial():
      return const Center(child: SponsorsShimmer());
    case SponsorsStateLoading():
      return const Center(child: SponsorsShimmer());
    case SponsorsStateLoaded(
        cplSponsors: List<SponsorsData> cplSponsors,
        wcplSponsors: List<SponsorsData> wcplSponsors
      ):
      List<SponsorsData> sponsors =
          (selectedCategory == CategoryType.cpl) ? cplSponsors : wcplSponsors;
      return Padding(
          padding: UIDimensions.symmetricPaddingInsets(horizontal: 16),
          child: Column(
            children: [
              // Center(
              //   child: CustomText.headlineSmall(
              //     "COMMERCIAL PARTNERS",
              //     color: context.customColors.purpleVariant2,
              //     fontWeight: FontWeight.w500,
              //   ),
              // ),
              //UIDimensions.verticalSpaceMedium,
              ...List.generate(
                sponsors.length,
                (index) => Column(
                  children: [
                    Center(
                      child: CustomText.headlineSmall(
                        sponsors[index].slug?.toTitleCaseFromSnakeCase ?? "",
                        color: context.customColors.purpleVariant2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    UIDimensions.verticalSpaceSmall,
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: UIDimensions.width(20),
                      runSpacing: UIDimensions.height(20),
                      children: [
                        ...List.generate(
                          sponsors[index].acf?.sponsors?.length ?? 0,
                          (idx) => InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () async {
                              final Uri url = Uri.parse(sponsors[index]
                                      .acf
                                      ?.sponsors?[idx]
                                      .sponsorLink ??
                                  "");
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url);
                              } else {
                                if (context.mounted) {
                                  SnackbarFactory.showError(
                                      "Can not launch URL");
                                }
                              }
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl: sponsors[index]
                                        .acf
                                        ?.sponsors?[idx]
                                        .sponsorLogo ??
                                    "",
                                fit: BoxFit.contain,
                                placeholder: (context, url) {
                                  return const ImagePlaceholder(
                                    height: 50,
                                    width: 50,
                                  );
                                },
                                errorWidget: (context, url, error) {
                                  return Assets.images.errorImage
                                      .image(height: 50, width: 50);
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    UIDimensions.verticalSpaceLarge,
                  ],
                ),
              )
            ],
          ));
    case SponsorsStateError():
      return const SizedBox();
  }
}

Widget partners(WidgetRef ref, BuildContext context) {
  final partnerState = ref.watch(partnersNotifierProvider);
  final selectedCategory = ref.watch(selectedCategoryNotifierProvider);
  switch (partnerState) {
    case PartnersStateInitial():
      return const Center(child: PartnersShimmer());
    case PartnersStateLoading():
      return const Center(child: PartnersShimmer());
    case PartnersStateLoaded(
        cplPartners: List<PartnersData> cplPartners,
        wcplPartners: List<PartnersData> wcplPartners
      ):
      final partners =
          selectedCategory == CategoryType.cpl ? cplPartners : wcplPartners;
      return Padding(
          padding: UIDimensions.symmetricPaddingInsets(horizontal: 16),
          child: Column(
            children: [
              ...List.generate(
                partners.length,
                (index) => Column(
                  children: [
                    Center(
                      child: CustomText.headlineSmall(
                        partners[index].slug?.toTitleCaseFromSnakeCase ?? "",
                        color: context.customColors.purpleVariant2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    UIDimensions.verticalSpaceSmall,
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: UIDimensions.width(20),
                      runSpacing: UIDimensions.height(20),
                      children: [
                        ...List.generate(
                          partners[index].acf?.partners?.length ?? 0,
                          (idx) => InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () async {
                              final Uri url = Uri.parse(partners[index]
                                      .acf
                                      ?.partners?[idx]
                                      .partnerLink ??
                                  "");
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url);
                              } else {
                                if (context.mounted) {
                                  SnackbarFactory.showError(
                                      "Can not launch URL");
                                }
                              }
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl: partners[index]
                                        .acf
                                        ?.partners?[idx]
                                        .partnerLogo ??
                                    "",
                                fit: BoxFit.contain,
                                placeholder: (context, url) {
                                  return const ImagePlaceholder(
                                    height: 50,
                                    width: 50,
                                  );
                                },
                                errorWidget: (context, url, error) {
                                  return Assets.images.errorImage
                                      .image(height: 50, width: 50);
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    UIDimensions.verticalSpaceLarge,
                  ],
                ),
              )
            ],
          ));
    case PartnersStateError():
      return const SizedBox();
  }
}

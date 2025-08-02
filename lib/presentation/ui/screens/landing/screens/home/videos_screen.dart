import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/utils/assets_gen/assets.gen.dart';
import '../../../../../../core/utils/assets_gen/fonts.gen.dart';
import '../../../../../../core/utils/extensions/context_extension.dart';
import '../../../../../../core/utils/styles/dimensions/ui_dimensions.dart';
import '../../../../../../domain/states/yt_video_state.dart';
import '../../../../../providers/videos/video_provider.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/error_cards/something_went_wrong_card.dart';
import '../../../../widgets/shimmer/common_shimmer.dart';
import '../../../../widgets/shimmer/videos_shimmer.dart';
import 'widgets/highlight_container.dart';

@RoutePage()
class VideosScreen extends ConsumerStatefulWidget {
  const VideosScreen({super.key});

  @override
  ConsumerState<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends ConsumerState<VideosScreen> {
  late ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        if ((ref.read(ytVideoNotifierProvider) is YtVideoStateLoaded) &&
            ((ref.read(ytVideoNotifierProvider) as YtVideoStateLoaded)
                .isFetching)) {
          return;
        }
        ref.read(ytVideoNotifierProvider.notifier).getVideos(fetchMore: true);
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(ytVideoNotifierProvider.notifier).getVideos();
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return ref
            .read(ytVideoNotifierProvider.notifier)
            .getVideos(onRefresh: true);
      },
      child: CustomScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            scrolledUnderElevation: 0.0,
            expandedHeight: kToolbarHeight + 100,
            toolbarHeight: kToolbarHeight + 100,
            automaticallyImplyLeading: false,
            backgroundColor: context.colorScheme.background,
            flexibleSpace: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    color: const Color(0xff050519),
                    height: 100,
                    width: context.screenWidth,
                  ),
                ),
                Positioned(
                    top: 50,
                    left: 16,
                    child: InkWell(
                      onTap: () async {
                        await context.maybePop();
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 16,
                      ),
                    )),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Assets.images.vide0DetailAppbar.image(),
                ),
                Positioned(
                    top: 125,
                    left: 20,
                    child: CustomText.displayLarge(
                      "VIDEOS",
                      fontSize: 35,
                      fontFamily: FontFamily.anekOdia,
                      color: context.customColors.purpleVariant2,
                    )),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: videos(),
          )
        ],
      ),
    );
  }

  Widget videos() {
    final videosState = ref.watch(ytVideoNotifierProvider);
    return switch (videosState) {
      YtVideoStateInitial() => const VideosShimmer(),
      YtVideoStateLoading() => const VideosShimmer(),
      YtVideoStateLoaded(videos: var videos, isFetching: bool isFetching) =>
        (videos.items != null && videos.items!.isNotEmpty)
            ? Column(
                children: [
                  GridView.count(
                    padding: UIDimensions.onlyPaddingInsets(right: 12),
                    crossAxisCount: 2,
                    childAspectRatio: 1.6,
                    shrinkWrap: true,
                    mainAxisSpacing: 15,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      ...List.generate(
                        videos.items?.length ?? 0,
                        (index) => HighlightContainer(
                          video: videos.items![index],
                        ),
                      ),
                    ],
                  ),
                  if (isFetching)
                    Padding(
                      padding:
                          UIDimensions.symmetricPaddingInsets(horizontal: 12),
                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        childAspectRatio: 1.6,
                        mainAxisSpacing: 5,
                        shrinkWrap: true,
                        children: [
                          ...List.generate(
                            2,
                            (index) =>
                                const CommonShimmer(height: 120, width: 200),
                          ),
                        ],
                      ),
                    ),
                ],
              )
            : const Center(
                child: CustomText.bodyMedium("No videos available"),
              ),
      YtVideoStateError(ex: var _) => SomethingWentWrongCard(onPressed: () {
          ref.read(ytVideoNotifierProvider.notifier).getVideos();
        }),
    };
  }
}

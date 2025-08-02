import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/router/app_router.dart';
import '../../../../../../../core/utils/extensions/context_extension.dart';
import '../../../../../../../core/utils/styles/dimensions/ui_dimensions.dart';
import '../../../../../../../domain/states/yt_video_state.dart';
import '../../../../../../providers/videos/video_provider.dart';
import '../../../../../widgets/header.dart';
import '../../../../../widgets/shimmer/videos_shimmer.dart';
import 'highlight_container.dart';

class MatchHeighlightsWidget extends ConsumerStatefulWidget {
  const MatchHeighlightsWidget({super.key});

  @override
  ConsumerState<MatchHeighlightsWidget> createState() =>
      _MatchHeighlightsWidgetState();
}

class _MatchHeighlightsWidgetState
    extends ConsumerState<MatchHeighlightsWidget> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeVideoNotifierProvider.notifier).getHomeVideos();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var videoState = ref.watch(homeVideoNotifierProvider);
    return switch (videoState) {
      YtVideoStateInitial() =>
        const VideosShimmer(axisDirection: Axis.horizontal),
      YtVideoStateLoading() =>
        const VideosShimmer(axisDirection: Axis.horizontal),
      YtVideoStateLoaded(videos: var videos) =>
        (videos.items != null && videos.items!.isNotEmpty)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Header(
                    arrowCount: 5,
                    title: "Videos",
                    titleColor:
                        context.customColors.primaryPurple ?? Colors.white,
                    subTitleColor: Colors.white,
                    arrowColor:
                        context.customColors.primaryPurple ?? Colors.white,
                    onTap: () => context.pushRoute(const VideosRoute()),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    child: Row(
                      children: [
                        ...List.generate(
                          (videos.items?.length ?? 0) > 4
                              ? 4
                              : (videos.items?.length ?? 0),
                          (index) => HighlightContainer(
                            video: videos.items![index],
                          ),
                        )
                      ],
                    ),
                  ),
                  UIDimensions.verticalSpace(12),
                ],
              )
            : const SizedBox.shrink(),
      YtVideoStateError(ex: var _) => const SizedBox.shrink(),
    };
  }
}

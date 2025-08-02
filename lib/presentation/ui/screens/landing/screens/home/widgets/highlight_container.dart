import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../../../../core/utils/assets_gen/assets.gen.dart';
import '../../../../../../../core/utils/extensions/context_extension.dart';
import '../../../../../../../core/utils/extensions/string_extensions.dart';
import '../../../../../../../core/utils/styles/dimensions/ui_dimensions.dart';
import '../../../../../../../domain/models/yt_video/yt_video.dart';
import '../../../../../widgets/custom_text.dart';

class HighlightContainer extends ConsumerWidget {
  final YtItems? video;
  final String? url;
  const HighlightContainer({super.key, this.video, this.url});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => _showVideoDialog(context, video, url: url),
      child: Padding(
        padding: UIDimensions.onlyPaddingInsets(left: 16.0),
        child: Stack(
          children: [
            Container(
              height: 120,
              width: 200,
              decoration: BoxDecoration(
                  border: Border.all(
                      color:
                          context.customColors.purpleVariant2 ?? Colors.white),
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(url != null
                        ? url!.youtubeThumbnail
                        : video?.snippet?.thumbnails?.high?.url ?? ""),
                    fit: BoxFit.cover,
                  )),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: UIDimensions.onlyPaddingInsets(bottom: 8, right: 4),
                  child: Assets.icons.play.svg(),
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 4,
              child: Container(
                width: 60,
                height: 30,
                decoration: BoxDecoration(
                    color: context.customColors.black40Color,
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Padding(
                padding: UIDimensions.onlyPaddingInsets(bottom: 8, right: 4),
                child: Visibility(
                  visible: false,
                  child: Container(
                      padding: UIDimensions.onlyPaddingInsets(
                          left: 4, right: 4, top: 8),
                      child: const CustomText.bodySmall(
                        "",
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

void _showVideoDialog(BuildContext context, YtItems? video, {String? url}) {
  showDialog(
    barrierDismissible: true,
    useSafeArea: true,
    context: context,
    builder: (BuildContext context) {
      YoutubePlayerController controller = YoutubePlayerController(
        initialVideoId: !(url != null)
            ? video?.id?.videoId ?? ""
            : (url.extractVideoId(Uri.parse(url)) ?? ""),
        flags: const YoutubePlayerFlags(
            autoPlay: true,
            mute: false,
            hideControls: false,
            enableCaption: true),
      );
      return Stack(
        alignment: Alignment.center,
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              color: Colors.black.withOpacity(0.3),
            ),
          ),
          Dialog(
            backgroundColor: context.customColors.grey2Color,
            insetPadding: const EdgeInsets.all(8),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
              height: 300.0,
              width: context.screenWidth,
              child: Stack(
                children: <Widget>[
                  Container(
                    width: context.screenWidth,
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: YoutubePlayer(
                      controller: controller,
                      width: context.screenWidth,
                      showVideoProgressIndicator: true,
                      onReady: () {
                        controller.addListener(() {
                          // Add listeners here if needed
                        });
                      },
                    ),
                  ),
                  Align(
                    alignment: const Alignment(1.05, -1.05),
                    child: GestureDetector(
                      onTap: () {
                        controller.pause();
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: UIDimensions.allPaddingInsets(8.0),
                        child: const CircleAvatar(
                          radius: 15,
                          child: Icon(
                            (Icons.close),
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      );
    },
  );
}

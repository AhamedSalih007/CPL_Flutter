import 'package:flutter/material.dart';

import '../../../../../../../core/utils/extensions/context_extension.dart';
import '../../../../../../../core/utils/extensions/string_extensions.dart';
import '../../../../../../../core/utils/styles/dimensions/ui_dimensions.dart';
import '../../../../../../../domain/models/match_details/match_details.dart';
import '../../../../../widgets/custom_text.dart';

class MatchInfoContainer extends StatelessWidget {
  const MatchInfoContainer({super.key, required this.matchDetails});
  final MatchDetails matchDetails;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: UIDimensions.allPaddingInsets(16.0),
      child: ListView(
        padding: UIDimensions.onlyPaddingInsets(top: 0),
        children: [
          Container(
            decoration: BoxDecoration(
                color: context.customColors.purpleVariant,
                borderRadius: BorderRadius.circular(8)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                UIDimensions.verticalSpaceMedium,
                InfoTile(
                    title: "Match",
                    val:
                        "${matchDetails.teams?[0].shortName ?? ""} vs ${matchDetails.teams?[1].shortName ?? ""}"),
                InfoTile(title: "Series", val: "${matchDetails.format}"),
                InfoTile(
                    title: "Date", val: "${matchDetails.startDate?.eeemmd}"),
                InfoTile(
                    title: "Time", val: "${matchDetails.startDate?.gmtTime}"),
                if (matchDetails.toss != null)
                  InfoTile(
                      title: "Toss",
                      val:
                          "${matchDetails.toss?.wonByName} won the toss and chose to ${matchDetails.toss?.decision}"),
                if (matchDetails.venue != null)
                  InfoTile(
                    title: "Venue",
                    val: "${matchDetails.venue?.fullName}",
                    isDivider: false,
                  ),
                if (matchDetails.umpires != null &&
                    matchDetails.umpires!.isNotEmpty)
                  InfoTile(
                    title: "Umpires",
                    val: "${matchDetails.umpires}",
                    isDivider: false,
                  ),
                if (matchDetails.thirdUmpire != null &&
                    matchDetails.thirdUmpire!.isNotEmpty)
                  InfoTile(
                    title: "Third Umpires",
                    val: "${matchDetails.thirdUmpire}",
                    isDivider: false,
                  ),
                if (matchDetails.fourthUmpire != null &&
                    matchDetails.fourthUmpire!.isNotEmpty)
                  InfoTile(
                    title: "Fourth Umpires",
                    val: "${matchDetails.umpires}",
                    isDivider: false,
                  ),
                if (matchDetails.referee != null &&
                    matchDetails.referee!.isNotEmpty)
                  InfoTile(
                    title: "Match Referee",
                    val: "${matchDetails.referee}",
                    isDivider: false,
                  ),
                UIDimensions.verticalSpaceMedium,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class InfoTile extends StatelessWidget {
  const InfoTile(
      {super.key,
      required this.title,
      required this.val,
      this.isDivider = true});

  final String title;
  final String val;
  final bool isDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UIDimensions.verticalSpaceSmall,
        InfoContent(
          title: title,
          value: val,
        ),
        UIDimensions.verticalSpaceSmall,
        if (isDivider)
          Divider(
            color: context.customColors.blueVarient,
          )
      ],
    );
  }
}

class InfoContent extends StatelessWidget {
  final String title;
  final String value;
  const InfoContent({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: UIDimensions.symmetricPaddingInsets(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: context.screenWidth * 0.15,
            child: CustomText.titleMedium(
              title,
              color: context.colorScheme.tertiary,
              maxLines: 2,
            ),
          ),
          SizedBox(
            width: context.screenWidth * 0.6,
            child: CustomText.titleMedium(
              value,
              maxLines: 3,
              color: context.colorScheme.onSurface,
            ),
          )
        ],
      ),
    );
  }
}

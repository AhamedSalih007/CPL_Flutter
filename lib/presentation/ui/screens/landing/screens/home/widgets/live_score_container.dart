// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../../../../../core/utils/assets_gen/assets.gen.dart';
// import '../../../../../../../core/utils/extensions/context_extension.dart';
// import '../../../../../../../core/utils/styles/dimensions/ui_dimensions.dart';
// import '../../../../../../../domain/enums/match_status.dart';
// import '../../../../../../../domain/models/match/match.dart';
// import '../../../../../widgets/custom_text.dart';

// class ScoreContainer extends ConsumerWidget {
//   final double? width;
//   final MatchModel match;
//   final double? leftPadding;
//   const ScoreContainer(
//       {super.key, required this.match, this.width, this.leftPadding});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Padding(
//       padding: UIDimensions.onlyPaddingInsets(left: leftPadding ?? 12),
//       child: Container(
//         width: width ?? context.screenWidth * 0.85,
//         decoration: BoxDecoration(
//           //color: context.customColors.black40Color,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//             color: context.colorScheme.tertiary,
//           ),
//         ),
//         child: Padding(
//           padding: UIDimensions.allPaddingInsets(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   CustomText.titleMedium(
//                     "Match 1 of 5",
//                     fontWeight: FontWeight.bold,
//                     color: context.customColors.grey4Color,
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(99),
//                       color: match.matchStatus == MatchStatus.live
//                           ? context.customColors.secondaryRed
//                           : context.customColors.white10Color,
//                     ),
//                     child: Padding(
//                       padding: UIDimensions.onlyPaddingInsets(
//                           left: 25, right: 25, top: 8, bottom: 6),
//                       child: Text(
//                         match.matchStatus.val.toUpperCase(),
//                         style: const TextStyle(
//                             fontSize: 10,
//                             color: Colors.white,
//                             fontWeight: FontWeight.w700),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//               UIDimensions.verticalSpaceMedium,
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Flexible(
//                     child: SizedBox(
//                       width: context.screenWidth * 0.32,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Column(
//                             children: [
//                               Assets.images.teamBarbadosRoyals
//                                   .image(width: 42, height: 47),
//                               CustomText.bodyMedium(
//                                 "BR",
//                                 color: context.customColors.textColor,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ],
//                           ),
//                           UIDimensions.horizontalSpaceSmall,
//                           Visibility(
//                             visible: match.matchStatus == MatchStatus.live ||
//                                 match.matchStatus == MatchStatus.completed,
//                             child: const Column(
//                               children: [
//                                 CustomText.displaySmall(
//                                   "235-5",
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                                 CustomText.bodyMedium(
//                                   "20 Overs",
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   (match.matchStatus == MatchStatus.upcoming)
//                       ? const Flexible(
//                           child: Column(
//                             children: [
//                               CustomText.bodyMedium(
//                                 "Match starts in ",
//                               ),
//                               CustomText.displaySmall(
//                                 "29:20s",
//                                 fontWeight: FontWeight.w700,
//                               ),
//                             ],
//                           ),
//                         )
//                       : const CustomText.bodyMedium(
//                           "V/S",
//                           fontWeight: FontWeight.w600,
//                         ),
//                   Flexible(
//                     child: SizedBox(
//                       width: context.screenWidth * 0.32,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Visibility(
//                             visible: match.matchStatus == MatchStatus.live ||
//                                 match.matchStatus == MatchStatus.completed,
//                             child: Expanded(
//                               child: match.matchStatus == MatchStatus.completed
//                                   ? const Column(
//                                       children: [
//                                         CustomText.displaySmall(
//                                           "220-5",
//                                           fontWeight: FontWeight.w700,
//                                         ),
//                                         CustomText.bodyMedium(
//                                           "20 Overs",
//                                         ),
//                                       ],
//                                     )
//                                   : const CustomText.bodyMedium(
//                                       "Yet to bat",
//                                     ),
//                             ),
//                           ),
//                           UIDimensions.horizontalSpaceSmall,
//                           Column(
//                             children: [
//                               Assets.images.amazonWarriors
//                                   .image(width: 42, height: 47),
//                               CustomText.bodyMedium(
//                                 "GAW",
//                                 fontWeight: FontWeight.w600,
//                                 color: context.customColors.textColor,
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               UIDimensions.verticalSpaceSmall,
//               const Divider(
//                 color: Color.fromRGBO(255, 255, 255, 0.3),
//               ),
//               UIDimensions.verticalSpaceSmall,
//               (match.matchStatus == MatchStatus.live)
//                   ? const CustomText.bodyMedium(
//                       "Barbados Royals need 235 runs to win",
//                       fontWeight: FontWeight.w500,
//                     )
//                   : (match.matchStatus == MatchStatus.completed)
//                       ? const CustomText.bodyMedium(
//                           "Barbados Royals Won by 5 Wickets",
//                           fontWeight: FontWeight.w500,
//                         )
//                       : Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             CustomText.bodyMedium(
//                               "Starts at 8 PM",
//                               color: context.customColors.textColor,
//                               fontWeight: FontWeight.w500,
//                             ),
//                             Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(8),
//                                 color: context.customColors.primaryPurple,
//                               ),
//                               child: Padding(
//                                 padding: UIDimensions.onlyPaddingInsets(
//                                     left: 25, right: 25, top: 8, bottom: 6),
//                                 child: const CustomText.bodySmall(
//                                   "Buy Tickets",
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

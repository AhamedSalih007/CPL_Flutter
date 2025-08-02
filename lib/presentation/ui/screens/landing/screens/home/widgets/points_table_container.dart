import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/utils/assets_gen/assets.gen.dart';
import '../../../../../../../core/utils/extensions/context_extension.dart';
import '../../../../../../../core/utils/styles/dimensions/ui_dimensions.dart';
import '../../../../../../../domain/models/points_table/ponits_table.dart';
import '../../../../../../../domain/states/points_table_state.dart';
import '../../../../../../providers/points_table.dart/points_table_provider.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/error_cards/something_went_wrong_card.dart';
import '../../../../../widgets/shimmer/common_shimmer.dart';
import 'points_table.dart';

class PointsTableContainer extends ConsumerWidget {
  final Color borderColor;
  const PointsTableContainer({super.key, required this.borderColor});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pointsTableState = ref.watch(pointsTableNotifierProvider);
    final sortedTeams =
        ref.read(pointsTableNotifierProvider.notifier).getSortedTeams();
    return Padding(
        padding: UIDimensions.symmetricPaddingInsets(horizontal: 16),
        child: switch (pointsTableState) {
          PointsTableStateInitial() => CommonShimmer(
              height: context.screenHeight * 0.6, width: context.screenWidth),
          PointsTableStateLoading() => CommonShimmer(
              height: context.screenHeight * 0.6, width: context.screenWidth),
          PointsTableStateLoaded(pointsTableData: PointsTableData _) =>
            sortedTeams.isNotEmpty
                ? Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: borderColor)),
                    child: Padding(
                      padding: UIDimensions.allPaddingInsets(16),
                      child: Table(
                          columnWidths: const {
                            0: FlexColumnWidth(6),
                            1: FlexColumnWidth(1),
                            2: FlexColumnWidth(1),
                            3: FlexColumnWidth(1),
                            4: FlexColumnWidth(2),
                            5: FlexColumnWidth(1),
                          },
                          // border: TableBorder.all(color: Colors.transparent),
                          children: [
                            const TableRow(children: [
                              TableRowContent(content: "Team"),
                              TableRowContent(content: "M"),
                              TableRowContent(content: "W"),
                              TableRowContent(content: "L"),
                              TableRowContent(content: "NRR"),
                              TableRowContent(content: "Pts")
                            ]),
                            ...ref
                                .read(pointsTableNotifierProvider.notifier)
                                .getSortedTeams()
                                .asMap()
                                .entries
                                .map(
                                  (e) => TableRow(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 0.3)))),
                                    children: [
                                      Padding(
                                        padding:
                                            UIDimensions.symmetricPaddingInsets(
                                                vertical: 12),
                                        child: SizedBox(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText.titleMedium(
                                                (e.key + 1).toString(),
                                              ),
                                              UIDimensions.horizontalSpaceSmall,
                                              CachedNetworkImage(
                                                imageUrl:
                                                    e.value.logo?.small?.url ??
                                                        "",
                                                width: 24,
                                                height: 24,
                                                placeholder: (context, url) =>
                                                    const CommonShimmer(
                                                  height: 24,
                                                  width: 24,
                                                  cornerRadius: 999,
                                                ),
                                                errorWidget:
                                                    (context, url, error) {
                                                  return Assets
                                                      .images.errorImage
                                                      .image(
                                                    height: 24,
                                                    width: 24,
                                                  );
                                                },
                                              ),
                                              UIDimensions.horizontalSpaceSmall,
                                              Expanded(
                                                child: CustomText.titleMedium(
                                                  e.value.name ?? "",
                                                  maxLines: 3,
                                                ),
                                              ),
                                              UIDimensions.horizontalSpaceSmall,
                                            ],
                                          ),
                                        ),
                                      ),
                                      TableRowContent(
                                        content:
                                            e.value.matches?.toString() ?? "",
                                      ),
                                      TableRowContent(
                                        content: e.value.wins?.toString() ?? "",
                                      ),
                                      TableRowContent(
                                        content:
                                            e.value.losses?.toString() ?? "",
                                      ),
                                      TableRowContent(
                                        content:
                                            e.value.netRunRate?.toString() ??
                                                "",
                                      ),
                                      TableRowContent(
                                        content:
                                            e.value.points?.toString() ?? "",
                                      ),
                                    ],
                                  ),
                                )
                          ]),
                    ),
                  )
                : const Center(
                    child: SizedBox(
                        child: CustomText.bodyMedium(
                            "Points Table not available yet")),
                  ),
          PointsTableStateError() => Center(
              child: SomethingWentWrongCard(onPressed: () {
                ref.read(pointsTableNotifierProvider.notifier).getPointsTable();
              }),
            )
        });
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/utils/extensions/context_extension.dart';
import '../../../../../../../core/utils/styles/dimensions/ui_dimensions.dart';
import '../../../../../../../domain/enums/match_tab_type.dart';
import '../../../../../../../domain/enums/tab_type.dart';
import '../../../../../../providers/landing_provider.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/header.dart';
import 'points_table_container.dart';

class PointsTable extends ConsumerWidget {
  const PointsTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UIDimensions.verticalSpace(12),
        Header(
          title: "Points",
          subTitle: "Table",
          titleColor: context.colorScheme.secondary,
          subTitleColor: context.colorScheme.onSurface,
          arrowColor: context.colorScheme.secondary,
          onTap: () {
            ref
                .read(matchTabIndexNotifierProvider.notifier)
                .updateTo(MatchesTabType.pointsTable);
            AutoTabsRouter.of(context).setActiveIndex(TabType.matches.index);
            ref
                .read(tabIndexNotifierProvider.notifier)
                .updateTo(TabType.matches);
          },
        ),
        PointsTableContainer(borderColor: context.colorScheme.secondary),
      ],
    );
  }
}

class TableRowContent extends StatelessWidget {
  final String content;
  const TableRowContent({
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: UIDimensions.symmetricPaddingInsets(vertical: 12),
      child: CustomText.titleMedium(content),
    );
  }
}

import 'package:class_cloud/common/constants/app_colors.dart';
import 'package:class_cloud/common/constants/display_properties.dart';
import 'package:class_cloud/common/widgets/custom_app_bar.dart';
import 'package:class_cloud/core/design_system/text_style.dart';
import 'package:class_cloud/features/coach/screens/coach_details_screen/cubit/coach_details_cubit.dart';
import 'package:class_cloud/features/coach/screens/coach_details_screen/cubit/coach_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoachDetailsScreen extends StatelessWidget {
  const CoachDetailsScreen({required this.coachId, super.key});

  final String coachId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Coach Details',
        // actions: [_ShareButton()],
      ),
      backgroundColor: AppColors.white100,
      body: _CoachDetailsContent(coachId),
    );
  }
}

// class _ShareButton extends StatelessWidget {
//   const _ShareButton();

//   @override
//   Widget build(BuildContext context) {
//     return BlocSelector<CoachDetailsCubit, CoachDetailsState, bool>(
//       selector: (state) => state is CoachDetailsLoaded,
//       builder: (context, isLoaded) {
//         return Padding(
//           padding: DisplayProperties.defaultPadding,
//           child: IconButton(
//             onPressed: isLoaded ? () async {} : null,
//             icon: const Icon(
//               Icons.share,
//               color: AppColors.primaryColor,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

class _CoachDetailsContent extends StatelessWidget {
  const _CoachDetailsContent(this.coachId);

  final String coachId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoachDetailsCubit, CoachDetailsState>(
      builder: ((context, state) {
        if (state is CoachDetailsLoaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: DisplayProperties.defaultPaddingValue,
            ),
            child: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: DisplayProperties.defaultPaddingValue * 4,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _Table(
                        key: const ValueKey('CoachInfo'),
                        coachData: state.coach.tableData,
                      ),
                      const SizedBox(
                        height: DisplayProperties.defaultPaddingValue * 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else if (state is CoachDetailsError) {
          return Center(
            child: Text(
              state.error.toString(),
              style: TextStyles.body01,
            ),
          );
        } else if (state is CoachDetailsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return const SizedBox();
      }),
    );
  }
}

class _Table extends StatelessWidget {
  const _Table({
    super.key,
    required this.coachData,
  });

  final Map<String, Object> coachData;

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(
        color: AppColors.primaryColor,
        width: 1,
      ),
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(0.5),
        1: FlexColumnWidth(),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: coachData.entries
          .map(
            (entry) => TableRow(
              children: <Widget>[
                TableCell(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: SelectableText(
                      entry.key,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: SelectableText(
                      entry.value.toString(),
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}

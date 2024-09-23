import 'package:class_cloud/common/constants/app_colors.dart';
import 'package:class_cloud/common/constants/display_properties.dart';
import 'package:class_cloud/common/extensions/string_extensions.dart';
import 'package:class_cloud/common/widgets/custom_app_bar.dart';
import 'package:class_cloud/core/design_system/text_style.dart';
import 'package:class_cloud/features/course/screens/course_details_screen/cubit/course_details_cubit.dart';
import 'package:class_cloud/features/course/screens/course_details_screen/cubit/course_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseDetailsScreen extends StatelessWidget {
  const CourseDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: 'Course Details',
        // actions: [_ShareButton()],
      ),
      backgroundColor: AppColors.white100,
      body: _CourseDetailsContent(),
    );
  }
}

class _CourseDetailsContent extends StatelessWidget {
  const _CourseDetailsContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseDetailsCubit, CourseDetailsState>(
      builder: ((context, state) {
        if (state is CourseDetailsLoaded) {
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
                      Container(
                        decoration: BoxDecoration(
                          color: state.course.courseColor?.color,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('ID: ', style: TextStyles.heading03),
                            Text(
                              state.course.id!,
                              style: TextStyles.heading03,
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Schedule: ', style: TextStyles.heading03),
                            if (state.course.timeOfDay != null &&
                                state.course.dayOfWeek != null)
                              Text(
                                ' ${state.course.dayOfWeek?.name.capitalize()} @ ${state.course.timeOfDay!.format(context)} ',
                                style: TextStyles.heading03,
                              ),
                          ],
                        ),
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
        } else if (state is CourseDetailsError) {
          return Center(
            child: Text(
              state.error.toString(),
              style: TextStyles.body01,
            ),
          );
        } else if (state is CourseDetailsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return const SizedBox();
      }),
    );
  }
}

// class _Table extends StatelessWidget {
//   const _Table({
//     super.key,
//     required this.schoolData,
//   });

//   final Map<String, Object> schoolData;

//   @override
//   Widget build(BuildContext context) {
//     return Table(
//       border: TableBorder.all(
//         color: AppColors.primaryColor,
//         width: 1,
//       ),
//       columnWidths: const <int, TableColumnWidth>{
//         0: FlexColumnWidth(0.5),
//         1: FlexColumnWidth(),
//       },
//       defaultVerticalAlignment: TableCellVerticalAlignment.middle,
//       children: schoolData.entries
//           .map(
//             (entry) => TableRow(
//               children: <Widget>[
//                 TableCell(
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//                     child: SelectableText(
//                       entry.key,
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//                 TableCell(
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//                     child: SelectableText(
//                       entry.value.toString(),
//                       style: const TextStyle(fontSize: 18),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           )
//           .toList(),
//     );
//   }
// }

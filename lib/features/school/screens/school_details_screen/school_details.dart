import 'package:class_cloud/common/constants/app_colors.dart';
import 'package:class_cloud/common/constants/display_properties.dart';
import 'package:class_cloud/common/widgets/custom_app_bar.dart';
import 'package:class_cloud/core/data/school/models/course.dart';
import 'package:class_cloud/core/design_system/text_style.dart';
import 'package:class_cloud/features/school/screens/school_details_screen/cubit/school_details_cubit.dart';
import 'package:class_cloud/features/school/screens/school_details_screen/cubit/school_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SchoolDetailsScreen extends StatelessWidget {
  const SchoolDetailsScreen({required this.schoolId, super.key});

  final String schoolId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'School Details',
        // actions: [_ShareButton()],
      ),
      backgroundColor: AppColors.white100,
      body: _SchoolDetailsContent(schoolId),
    );
  }
}

// class _ShareButton extends StatelessWidget {
//   const _ShareButton();

//   @override
//   Widget build(BuildContext context) {
//     return BlocSelector<SchoolDetailsCubit, SchoolDetailsState, bool>(
//       selector: (state) => state is SchoolDetailsLoaded,
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

class _SchoolDetailsContent extends StatelessWidget {
  const _SchoolDetailsContent(this.schoolId);

  final String schoolId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SchoolDetailsCubit, SchoolDetailsState>(
      builder: ((context, state) {
        if (state is SchoolDetailsLoaded) {
          final courses = state.school.courses;
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
                      Text(
                        state.school.id,
                        style: TextStyles.heading03,
                      ),
                      const SizedBox(
                        height: DisplayProperties.defaultPaddingValue * 2,
                      ),
                      Text(
                        state.school.name,
                        style: TextStyles.heading03,
                      ),
                      const SizedBox(
                        height: DisplayProperties.defaultPaddingValue * 2,
                      ),
                      ...courses.map(
                        (course) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            tileColor: course.courseColor.color,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            title: Text(course.id.toUpperCase(),
                                style: TextStyles.body01
                                    .copyWith(color: AppColors.white100)),
                            subtitle: Text(
                                '${course.dayOfWeek.name.toUpperCase()} - ${course.timeOfDay.prettyTime}',
                                style: TextStyles.body02
                                    .copyWith(color: AppColors.white100)),
                          ),
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
        } else if (state is SchoolDetailsError) {
          return Center(
            child: Text(
              state.error.toString(),
              style: TextStyles.body01,
            ),
          );
        } else if (state is SchoolDetailsLoading) {
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
    required this.schoolData,
  });

  final Map<String, Object> schoolData;

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
      children: schoolData.entries
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

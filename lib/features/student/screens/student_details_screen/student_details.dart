
import 'package:class_cloud/common/constants/app_colors.dart';
import 'package:class_cloud/common/constants/display_properties.dart';
import 'package:class_cloud/common/widgets/custom_app_bar.dart';
import 'package:class_cloud/core/design_system/text_style.dart';
import 'package:class_cloud/features/student/screens/student_details_screen/cubit/student_details_cubit.dart';
import 'package:class_cloud/features/student/screens/student_details_screen/cubit/student_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentDetailsScreen extends StatelessWidget {
  const StudentDetailsScreen({required this.studentId, super.key});

  final String studentId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Student Details',
        // actions: [_ShareButton()],
      ),
      backgroundColor: AppColors.white100,
      body: _StudentDetailsContent(studentId),
    );
  }
}

// class _ShareButton extends StatelessWidget {
//   const _ShareButton();

//   @override
//   Widget build(BuildContext context) {
//     return BlocSelector<StudentDetailsCubit, StudentDetailsState, bool>(
//       selector: (state) => state is StudentDetailsLoaded,
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

class _StudentDetailsContent extends StatelessWidget {
  const _StudentDetailsContent(this.studentId);

  final String studentId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentDetailsCubit, StudentDetailsState>(
      builder: ((context, state) {
        if (state is StudentDetailsLoaded) {
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
                        key: const ValueKey('StudentInfo'),
                        studentData: state.student.toTableData,
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
        } else if (state is StudentDetailsError) {
          return Center(
            child: Text(
              state.error.toString(),
              style: TextStyles.body01,
            ),
          );
        } else if (state is StudentDetailsLoading) {
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
    required this.studentData,
  });

  final Map<String, Object> studentData;

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
      children: studentData.entries
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

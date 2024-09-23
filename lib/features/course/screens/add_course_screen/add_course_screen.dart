import 'package:class_cloud/common/constants/display_properties.dart';
import 'package:class_cloud/common/extensions/string_extensions.dart';
import 'package:class_cloud/common/widgets/custom_app_bar.dart';
import 'package:class_cloud/core/data/course/model/course.dart';
import 'package:class_cloud/core/design_system/text_style.dart';
import 'package:class_cloud/core/go_router/go_router_keys.dart';
import 'package:class_cloud/features/course/screens/add_course_screen/cubit/add_course_cubit.dart';
import 'package:class_cloud/features/course/screens/add_course_screen/cubit/add_course_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddCourseScreen extends StatelessWidget {
  const AddCourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final school = context.read<AddCourseCubit>().school;
    return Scaffold(
      appBar: CustomAppBar(title: 'Add Course for $school'),
      body: BlocConsumer<AddCourseCubit, AddCourseState>(
        listener: (context, state) {
          if (state is AddCourseSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Course added successfully!'),
              ),
            );
            context.goNamed(GoRouterNames.courseDetails,
                pathParameters: {'courseId': state.courseId});
          }
        },
        builder: (context, state) {
          if (state is AddCourseInitial) {
            return const _AddCourseContent();
          }
          if (state is AddCourseError) {
            return Center(
              child: Text(
                'Error fetching course data',
                style: TextStyles.body01,
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class _AddCourseContent extends StatelessWidget {
  const _AddCourseContent();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 48,
                child: Divider(),
              ),
              const _ColorInput(),
              const SizedBox(
                height: 48,
                child: Divider(),
              ),
              const _DayInput(),
              const SizedBox(
                height: 48,
                child: Divider(),
              ),
              const _TimeInput(),
              const SizedBox(
                height: 48,
                child: Divider(),
              ),
              Text('Select Coaches', style: TextStyles.body01),
              const _CoachesList(),
              const SizedBox(
                height: 48,
                child: Divider(),
              ),
              Text('Select Students', style: TextStyles.body01),
              const _StudentList(),
              const SizedBox(
                height: 48,
              ),
            ],
          ),
        ),
        const Align(
          alignment: Alignment.bottomCenter,
          child: _AddCourseButton(),
        ),
      ],
    );
  }
}

class _AddCourseButton extends StatelessWidget {
  const _AddCourseButton();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.read<AddCourseCubit>().addCourse();
      },
      child: const Text('Add Course'),
    );
  }
}

class _ColorInput extends StatelessWidget {
  const _ColorInput({
    this.focusNode,
    this.nextFocusNode,
  });

  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddCourseCubit, AddCourseState,
        ({String error, CourseColor? value})>(
      selector: (state) => state is AddCourseInitial
          ? state.courseColor
          : (error: '', value: null),
      builder: (BuildContext context, colorRecord) {
        return DropdownButton<CourseColor>(
          hint: const Text('Color'),
          value: colorRecord.value,
          icon: const Icon(Icons.arrow_drop_down),
          iconSize: DisplayProperties.iconSize,
          elevation: DisplayProperties.elevation,
          underline: Container(
            height: 0,
            color: Colors.white,
          ),
          onChanged: (CourseColor? newValue) {
            if (newValue != null) {
              context.read<AddCourseCubit>().updateCourseColor(newValue);
            }
          },
          items: CourseColor.values
              .map<DropdownMenuItem<CourseColor>>((CourseColor value) {
            return DropdownMenuItem<CourseColor>(
              value: value,
              child: Text(
                value.name.capitalize(),
                style: TextStyles.heading03.copyWith(color: value.color),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _DayInput extends StatelessWidget {
  const _DayInput({
    this.focusNode,
    this.nextFocusNode,
  });

  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddCourseCubit, AddCourseState,
        ({String error, DayOfWeek? value})>(
      selector: (state) => state is AddCourseInitial
          ? state.dayOfWeek
          : (error: '', value: null),
      builder: (BuildContext context, dayOfWeek) {
        return DropdownButton<DayOfWeek>(
          hint: const Text('Day'),
          value: dayOfWeek.value,
          icon: const Icon(Icons.arrow_drop_down),
          iconSize: DisplayProperties.iconSize,
          elevation: DisplayProperties.elevation,
          underline: Container(
            height: 0,
            color: Colors.white,
          ),
          onChanged: (DayOfWeek? newValue) {
            if (newValue != null) {
              context.read<AddCourseCubit>().updateDayOfWeek(newValue);
            }
          },
          items: DayOfWeek.values
              .map<DropdownMenuItem<DayOfWeek>>((DayOfWeek value) {
            return DropdownMenuItem<DayOfWeek>(
              value: value,
              child: Text(value.name.capitalize()),
            );
          }).toList(),
        );
      },
    );
  }
}

class _TimeInput extends StatelessWidget {
  const _TimeInput({
    this.focusNode,
    this.nextFocusNode,
  });

  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddCourseCubit, AddCourseState,
        ({String error, TimeOfDay? value})>(
      selector: (state) => state is AddCourseInitial
          ? state.timeOfDay
          : (error: '', value: null),
      builder: (BuildContext context, timeOfDay) {
        return TextButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(timeOfDay.value?.prettyTime ?? 'Select Time'),
            ],
          ),
          onPressed: () async {
            final cubit = context.read<AddCourseCubit>();
            final TimeOfDay? picked = await showTimePicker(
              context: context,
              initialTime: timeOfDay.value ?? TimeOfDay.now(),
            );
            if (picked != null) {
              cubit.updateTimeOfDay(picked);
            }
          },
        );
      },
    );
  }
}

class _CoachesList extends StatelessWidget {
  const _CoachesList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCourseCubit, AddCourseState>(
      builder: (context, state) {
        if (state is AddCourseInitial && state.coaches.value.isNotEmpty) {
          return ListView(
            shrinkWrap: true,
            children: [
              for (var coachSelection in state.coaches.value)
                ListTile(
                  title: Text(
                      '${coachSelection.coach.firstName} ${coachSelection.coach.lastName}'),
                  trailing: Checkbox(
                    value: coachSelection.isSelected,
                    onChanged: (value) {
                      if (value != null) {
                        context.read<AddCourseCubit>().toggleCoach(
                              coachId: coachSelection.coach.id,
                              isSelected: value,
                            );
                      }
                    },
                  ),
                ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _StudentList extends StatelessWidget {
  const _StudentList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCourseCubit, AddCourseState>(
      builder: (context, state) {
        if (state is AddCourseInitial && state.students.value.isNotEmpty) {
          return ListView(
            shrinkWrap: true,
            children: [
              for (var studentSelection in state.students.value)
                ListTile(
                  title: Text(
                      '${studentSelection.student.firstName} ${studentSelection.student.lastName}'),
                  trailing: Checkbox(
                    value: studentSelection.isSelected,
                    onChanged: (value) {
                      if (value != null) {
                        context.read<AddCourseCubit>().toggleStudent(
                              studentId: studentSelection.student.id,
                              isSelected: value,
                            );
                      }
                    },
                  ),
                ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

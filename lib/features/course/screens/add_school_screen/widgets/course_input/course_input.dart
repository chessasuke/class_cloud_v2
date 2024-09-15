part of '../../add_school_screen.dart';

class _CourseInput extends StatelessWidget {
  const _CourseInput();

  @override
  Widget build(BuildContext showDialogContext) {
    return TextButton(
        onPressed: () {
          showDialog(
            context: showDialogContext,
            builder: (context) {
              return BlocProvider.value(
                value: showDialogContext.read<AddCourseCubit>(),
                child: const _AddCourseBody(),
              );
            },
          );
        },
        child: const Text('Add Course'));
  }
}

class _AddCourseBody extends StatelessWidget {
  const _AddCourseBody();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 8),
            Text(
              'Add Course',
              style: TextStyles.heading03,
            ),
            const SizedBox(height: 8),
            const _ColorInput(),
            const SizedBox(height: 8),
            const _DayInput(),
            const SizedBox(height: 8),
            const _TimeInput(),
            const SizedBox(height: 8),
            const _CoachesList(),
            const SizedBox(height: 8),
            const _StudentsList(),
            const SizedBox(height: 8),
            const _AddCourseButton(),
          ],
        ),
      ),
    );
  }
}

class _AddCourseButton extends StatelessWidget {
  const _AddCourseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.read<AddCourseCubit>().checkIfCourseReady();
        Navigator.of(context).pop();
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
              child: Text(value.name.capitalize()),
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
          print(' ---- coaches: ${state.coaches}');
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

class _StudentsList extends StatelessWidget {
  const _StudentsList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCourseCubit, AddCourseState>(
      builder: (context, state) {
        if (state is AddCourseInitial && state.students.value.isNotEmpty) {
          print(' ---- coaches: ${state.students}');
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

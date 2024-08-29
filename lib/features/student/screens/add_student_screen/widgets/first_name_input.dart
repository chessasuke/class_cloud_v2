part of '../add_student_screen.dart';

class _FirstNameInput extends StatelessWidget {
  const _FirstNameInput({
    required this.focusNode,
    required this.nextFocusNode,
  });

  final FocusNode focusNode;
  final FocusNode nextFocusNode;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddStudentCubit, AddStudentState,
        ({String error, String value})>(
      selector: (state) =>
          state is AddStudentInitial ? state.firstName : (error: '', value: ''),
      builder: (BuildContext context, firstNameRecord) {
        return BasicTextField(
          focusNode: focusNode,
          initialValue: firstNameRecord.value,
          labelText: ' First Name * ',
          onChanged: (value) {
            context.read<AddStudentCubit>().updateFirstName(value);
          },
          errorText:
              firstNameRecord.error.isEmpty ? null : firstNameRecord.error,
        );
      },
    );
  }
}

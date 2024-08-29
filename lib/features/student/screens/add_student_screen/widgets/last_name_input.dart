part of '../add_student_screen.dart';

class _LastNameInput extends StatelessWidget {
  const _LastNameInput({
    required this.focusNode,
  });

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddStudentCubit, AddStudentState,
        ({String error, String value})>(
      selector: (state) =>
          state is AddStudentInitial ? state.lastName : (error: '', value: ''),
      builder: (BuildContext context, lastNameRecord) {
        return BasicTextField(
          focusNode: focusNode,
          initialValue: lastNameRecord.value,
          labelText: ' Last Name * ',
          onChanged: (value) {
            context.read<AddStudentCubit>().updateLastName(value);
          },
          errorText: lastNameRecord.error.isEmpty ? null : lastNameRecord.error,
        );
      },
    );
  }
}

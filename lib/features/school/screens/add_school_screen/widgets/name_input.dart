part of '../add_school_screen.dart';

class _NameInput extends StatelessWidget {
  const _NameInput({
    required this.focusNode,
    // required this.nextFocusNode,
  });

  final FocusNode focusNode;
  // final FocusNode nextFocusNode;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddSchoolCubit, AddSchoolState,
        ({String error, String? value})>(
      selector: (state) =>
          state is AddSchoolInitial ? state.name : (error: '', value: ''),
      builder: (BuildContext context, emailRecord) {
        return BasicTextField(
          focusNode: focusNode,
          initialValue: emailRecord.value,
          labelText: ' School Name * ',
          onChanged: (value) {
            context.read<AddSchoolCubit>().updateName(value);
          },
          errorText: emailRecord.error.isEmpty ? null : emailRecord.error,
        );
      },
    );
  }
}

part of '../add_coach_screen.dart';

class _LastNameInput extends StatelessWidget {
  const _LastNameInput({
    required this.focusNode,
  });

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddCoachCubit, AddCoachState,
        ({String error, String value})>(
      selector: (state) =>
          state is AddCoachInitial ? state.lastName : (error: '', value: ''),
      builder: (BuildContext context, lastNameRecord) {
        return BasicTextField(
          focusNode: focusNode,
          initialValue: lastNameRecord.value,
          labelText: ' Last Name * ',
          onChanged: (value) {
            context.read<AddCoachCubit>().updateLastName(value);
          },
          errorText: lastNameRecord.error.isEmpty ? null : lastNameRecord.error,
        );
      },
    );
  }
}

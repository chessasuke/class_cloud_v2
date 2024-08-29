part of '../add_coach_screen.dart';

class _EmailInput extends StatelessWidget {
  const _EmailInput({
    required this.focusNode,
    required this.nextFocusNode,
  });

  final FocusNode focusNode;
  final FocusNode nextFocusNode;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddCoachCubit, AddCoachState,
        ({String error, String value})>(
      selector: (state) =>
          state is AddCoachInitial ? state.email : (error: '', value: ''),
      builder: (BuildContext context, emailRecord) {
        return BasicTextField(
          focusNode: focusNode,
          initialValue: emailRecord.value,
          labelText: ' Email * ',
          onChanged: (value) {
            context.read<AddCoachCubit>().updateEmail(value);
          },
          errorText: emailRecord.error.isEmpty ? null : emailRecord.error,
        );
      },
    );
  }
}

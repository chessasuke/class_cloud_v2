import 'package:class_cloud/core/design_system/text_style.dart';
import 'package:class_cloud/core/widgets/cta_button/cta_button.dart';
import 'package:flutter/material.dart';

showCairdioDialog({
  required BuildContext context,
  bool barrierDismissible = true,
  required String title,
  String? message,
  String? primaryButtonText,
  VoidCallback? onPrimaryButtonPressed,
}) {
  showDialog(
    barrierDismissible: barrierDismissible,
    context: context,
    builder: (context) {
      return CiardioDialog(
        title: title,
        message: message,
        primaryButtonText: primaryButtonText,
        onPrimaryButtonPressed: onPrimaryButtonPressed,
      );
    },
  );
}

class CiardioDialog extends StatelessWidget {
  const CiardioDialog({
    required this.title,
    this.message,
    this.primaryButtonText,
    this.onPrimaryButtonPressed,
    super.key,
  });

  final String title;
  final String? message;
  final String? primaryButtonText;
  final VoidCallback? onPrimaryButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 200,
        width: 300,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(title, style: TextStyles.heading03),
              ),
              if (message != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    message!,
                    style: TextStyles.body01,
                  ),
                ),
              const Spacer(),
              if (primaryButtonText != null)
                CtaButton(
                  text: primaryButtonText!,
                  onPressed: onPrimaryButtonPressed,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

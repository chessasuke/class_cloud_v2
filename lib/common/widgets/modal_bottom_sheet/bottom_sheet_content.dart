import 'package:class_cloud/common/widgets/modal_bottom_sheet/bottom_sheet_content_keys.dart';
import 'package:class_cloud/core/design_system/text_style.dart';
import 'package:class_cloud/core/widgets/cta_button/cta_button.dart';
import 'package:flutter/material.dart';

/// Use [descriptionText] for simple text and [descriptionWidget] for complex widgets (e.g., text with hyperlinks or
/// images). [descriptionText] and [descriptionWidget] cannot both be defined (non-null).
class BottomSheetContent extends StatelessWidget {
  const BottomSheetContent({
    required this.title,
    this.subtitle,
    this.body,
    this.onBackButtonPressed,
    this.descriptionText,
    this.descriptionWidget,
    this.descriptionSubTextWidget,
    this.primaryCtaText,
    this.primaryCtaOnPressed,
    this.isPrimaryCtaLoading = false,
    this.secondaryCtaText,
    this.secondaryCtaOnPressed,
    this.isSecondaryCtaDisabled = false,
    this.bottomTrailingWidget,
    this.nonBodyHorizontalPadding = 0,
    this.titleAlignment = Alignment.centerLeft,
    this.widgetKey = BottomSheetContentKeys.contentWidget,
  })  : assert(descriptionText == null || descriptionWidget == null),
        super(key: widgetKey);

  /// If non-null, back button is included in bottom sheet and uses the given method.
  final VoidCallback? onBackButtonPressed;
  final String title;

  /// If given, [subtitle] is displayed inline with [title] with a different text style.
  final String? subtitle;
  final Alignment titleAlignment;

  final String? descriptionText;
  final Widget? descriptionWidget;

  /// If non-null, text is displayed beneath the description.
  final Widget? descriptionSubTextWidget;

  /// If non-null, CTA with Primary style is displayed and uses the given onPressed method.
  final String? primaryCtaText;

  /// Must be non-null if [primaryCtaText] is non-null.
  final VoidCallback? primaryCtaOnPressed;

  /// true to display spinner while [primaryCtaOnPressed] is executing
  final bool isPrimaryCtaLoading;

  /// If non-null, CTA with secondary style is displayed and uses the given onPressed method.
  /// This should only be non-null if both [primaryCtaText] and [primaryCtaOnPressed] are both non-null.
  final String? secondaryCtaText;

  /// Must be non-null if [secondaryCtaText] is non-null.
  final VoidCallback? secondaryCtaOnPressed;

  final bool isSecondaryCtaDisabled;

  final Widget? body;
  final Widget? bottomTrailingWidget;

  /// If the body widget manages its own padding, padding must be applied separately to the other widgets.
  final double nonBodyHorizontalPadding;

  final ValueKey widgetKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: nonBodyHorizontalPadding),
          child: Column(
            children: [
              // _BottomSheetContentHeaderPaddingAndButton(
              //   onBackButtonPressed: onBackButtonPressed,
              //   widgetKey: widgetKey,
              // ),
              // Align(
              //   alignment: titleAlignment,
              //   child: RichText(
              //     key: BottomSheetContentKeys.title,
              //     text: TextSpan(
              //       children: <TextSpan>[
              //         TextSpan(
              //           text: '$title${subtitle != null ? ' ' : ''}',
              //           style: TextStyles.heading01,
              //         ),
              //         if (subtitle != null)
              //           TextSpan(
              //             text: subtitle,
              //             style: TextStyles.subheading01
              //                 .copyWith(color: AppColors.grayNeutral300),
              //           ),
              //       ],
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 36.0),
                child: Align(
                  alignment: titleAlignment,
                  child: Text(
                    title,
                    style: TextStyles.heading01,
                    key: BottomSheetContentKeys.title,
                  ),
                ),
              ),
              if (descriptionText != null) ...[
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    descriptionText!,
                    key: BottomSheetContentKeys.description,
                    style: TextStyles.body01,
                  ),
                ),
              ],

              if (primaryCtaText != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: CtaButton(
                    text: primaryCtaText!,
                    onPressed: primaryCtaOnPressed,
                  ),
                ),

              // if (descriptionWidget != null) ...[
              //   const SizedBox(height: 24),
              //   descriptionWidget!,
              // ],
              // if (descriptionSubTextWidget != null) ...[
              //   const SizedBox(
              //     height: 20,
              //   ),
              //   Align(
              //     alignment: Alignment.centerLeft,
              //     child: descriptionSubTextWidget,
              //   ),
              // ],
            ],
          ),
        ),
        // if (body != null) ...[
        //   const SizedBox(height: 24),
        //   body!,
        // ],
        // Padding(
        //   padding: EdgeInsets.symmetric(horizontal: nonBodyHorizontalPadding),
        //   child: _BottomSheetContentCtaButtons(
        //     primaryCtaText: primaryCtaText,
        //     primaryCtaOnPressed: primaryCtaOnPressed,
        //     isPrimaryCtaLoading: isPrimaryCtaLoading,
        //     secondaryCtaText: secondaryCtaText,
        //     secondaryCtaOnPressed: secondaryCtaOnPressed,
        //     isSecondaryCtaDisabled: isSecondaryCtaDisabled,
        //     widgetKey: widgetKey,
        //   ),
        // ),
        // if (bottomTrailingWidget != null)
        //   Padding(
        //     padding: EdgeInsets.symmetric(horizontal: nonBodyHorizontalPadding),
        //     child: _BottomSheetContentTrailingWidget(
        //       widgetKey: widgetKey,
        //       child: bottomTrailingWidget!,
        //     ),
        //   ),
      ],
    );
  }
}

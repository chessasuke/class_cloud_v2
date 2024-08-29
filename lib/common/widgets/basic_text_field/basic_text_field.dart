import 'package:class_cloud/common/constants/app_colors.dart';
import 'package:class_cloud/common/constants/display_properties.dart';
import 'package:class_cloud/common/extensions/extensions.dart';
import 'package:class_cloud/common/extensions/string_extensions.dart';
import 'package:class_cloud/core/design_system/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part 'basic_text_field.keys.dart';

/// A wrapper around the [TextField] widget to implement the Cairdio design system.
/// Refer to the [TextField] widget documentation for details about the following parameters:
/// [autofocus], [inputFormatters], [keyboardType], [obscureText], [onChanged], [textCapitalization],
/// and [textInputAction].
class BasicTextField extends StatefulWidget {
  const BasicTextField({
    this.autofocus = false,
    this.readOnly = false,
    this.controller,
    this.focusNode,
    this.errorText,
    this.hintText,
    this.initialValue,
    this.inputFormatters,
    this.autoFillHints,
    this.keyboardType,
    this.labelText,
    this.obscureText = false,
    this.onChanged,
    this.onSubmitted,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.onTap,
    this.prefixText,
    this.prefixIcon,
    this.suffixIcon,
    this.regexFilter,
    this.onFocusChange,
    this.fillColor = Colors.transparent,
    this.cursorColor = AppColors.black100,
    this.labelStyle,
    super.key,
  });

  final bool autofocus;
  final bool readOnly;

  final Color fillColor;
  final Color cursorColor;

  final TextStyle? labelStyle;

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? regexFilter;

  /// If [errorText] is not null, the text field decoration will be red.
  /// Additionally, if [errorText] is not empty, the error will be shown below the field.
  final String? errorText;

  /// If [hintText] is null, [labelText] is used as the hint.
  /// If [labelText] is also null, then no hint is shown.
  final String? hintText;

  final String? initialValue;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;

  final List<String>? autoFillHints;

  /// If not null, the label floats above the text field when the field is in focus.
  /// In the label position, the text is all uppercase.
  /// If [hintText] is null, [labelText] also appears in the field as the hint.
  /// In the hint position, the text is in the given case.
  final String? labelText;

  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final Function(String)? onSubmitted;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;

  final VoidCallback? onTap;
  final Widget? prefixIcon;
  final String? prefixText;

  final Widget? suffixIcon;

  final ValueChanged<bool>? onFocusChange;

  @override
  State<BasicTextField> createState() => _BasicTextFieldState();
}

class _BasicTextFieldState extends State<BasicTextField> {
  late final FocusNode _focusNode;
  late final TextEditingController _textEditingController;

  bool _isErrorState = false;
  String? _hintText;
  String? _labelText;

  void _initializeErrorState() {
    _isErrorState = widget.errorText != null;
  }

  void _initializeHint() => _hintText = widget.hintText ?? widget.labelText;

  void _initializeLabel() {
    if (_focusNode.hasPrimaryFocus || _textEditingController.text.isNotEmpty) {
      _labelText = widget.labelText?.toUpperCase();
    } else if (_textEditingController.text.isEmpty) {
      _labelText = widget.hintText ?? widget.labelText;
    }
  }

  void _updateLabelFocusNodeListener() {
    if (_focusNode.hasPrimaryFocus || _textEditingController.text.isNotEmpty) {
      setState(() {
        _labelText = widget.labelText?.toUpperCase();
        _hintText = '';
      });
    } else if (_textEditingController.text.isEmpty) {
      setState(() {
        _labelText = widget.hintText ?? widget.labelText;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _focusNode = widget.focusNode ?? FocusNode();

    _textEditingController = widget.controller ?? TextEditingController();
    _textEditingController.text = widget.initialValue ?? '';

    _initializeErrorState();
    _initializeHint();
    _initializeLabel();

    if (_labelText != null) {
      _focusNode.addListener(_updateLabelFocusNodeListener);
    }
  }

  @override
  void didUpdateWidget(covariant BasicTextField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.initialValue != oldWidget.initialValue && widget.readOnly) {
      _textEditingController.text = widget.initialValue ?? '';
    }

    if (widget.errorText != oldWidget.errorText) {
      _initializeErrorState();
    }

    if (widget.labelText != null && oldWidget.labelText == null) {
      _initializeHint();
      _initializeLabel();
      _focusNode.addListener(_updateLabelFocusNodeListener);
    } else if (widget.labelText == null && oldWidget.labelText != null) {
      _initializeHint();
      _labelText = null;
      _focusNode.removeListener(_updateLabelFocusNodeListener);
    } else if (widget.labelText != oldWidget.labelText) {
      _initializeHint();
      _initializeLabel();
    } else if (widget.hintText != oldWidget.hintText) {
      _initializeHint();
    }
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    } else {
      _focusNode.removeListener(_updateLabelFocusNodeListener);
    }
    if (widget.controller == null) {
      _textEditingController.dispose();
    }
    super.dispose();
  }

  /// Applies the regex pattern (if given). Attempts to preserve the cursor position. Does not assign to text to
  /// controller if [text] has all valid characters.
  void _onChanged(String text) {
    late String updatedText;
    if (widget.regexFilter == null) {
      updatedText = text;
    } else {
      updatedText = text.clear(regexFilter: widget.regexFilter!);

      if (updatedText != text) {
        _textEditingController.setTextAndPreserveCursorIndex(updatedText);
      }
    }
    widget.onChanged?.call(updatedText);
  }

  // display mechanism of the TextField.
  @override
  Widget build(BuildContext context) {
    final OutlineInputBorder errorBorder = DisplayProperties.errorBorder;
    final OutlineInputBorder focusedBorder = DisplayProperties.focusedBorder;
    final OutlineInputBorder unfocusedBorder =
        DisplayProperties.unfocusedBorder;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Focus(
          onFocusChange: widget.onFocusChange,
          child: TextField(
            readOnly: widget.readOnly,
            onTap: widget.onTap,
            key: BasicTextFieldKeys.textField,
            focusNode: _focusNode,
            autofocus: widget.autofocus,
            controller: _textEditingController,
            cursorColor: widget.cursorColor,
            cursorHeight: 20.0,
            cursorWidth: 1.0,
            autofillHints: widget.autoFillHints,
            decoration: InputDecoration(
              filled: true,
              fillColor: widget.fillColor,
              enabledBorder: _isErrorState ? errorBorder : unfocusedBorder,
              // Conditional below prevents unnecessary animation on hint when labelText is null.
              floatingLabelBehavior: _labelText == null
                  ? FloatingLabelBehavior.never
                  : FloatingLabelBehavior.auto,
              floatingLabelStyle: _isErrorState
                  ? TextStyles.caption01.copyWith(color: AppColors.redError500)
                  : widget.labelStyle ??
                      TextStyles.caption01
                          .copyWith(color: AppColors.grayNeutral300),
              focusColor: AppColors.black100,
              focusedBorder: _isErrorState ? errorBorder : focusedBorder,
              hintStyle: TextStyles.body01.copyWith(
                color: AppColors.grayNeutral300,
              ),
              hintText: _hintText,
              labelStyle: TextStyles.body01.copyWith(
                color: AppColors.grayNeutral300,
              ),
              labelText: _labelText,
              prefixIcon: widget.prefixIcon == null
                  ? null
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: widget.prefixIcon,
                    ),
              prefixIconConstraints: const BoxConstraints(),
              prefixText: widget.prefixText,
              prefixStyle: TextStyles.body01,
              suffixIconConstraints: const BoxConstraints(),
              suffixIcon: widget.suffixIcon == null
                  ? null
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: widget.suffixIcon,
                    ),
            ),
            inputFormatters: widget.inputFormatters,
            keyboardType: widget.keyboardType,
            obscureText: widget.obscureText,
            onChanged: _onChanged,
            onSubmitted: widget.onSubmitted,
            smartDashesType: SmartDashesType.disabled,
            smartQuotesType: SmartQuotesType.disabled,
            style: TextStyles.body01,
            textCapitalization: widget.textCapitalization,
            textInputAction: widget.textInputAction,
          ),
        ),
        if (widget.errorText != null && widget.errorText!.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            widget.errorText!,
            key: BasicTextFieldKeys.error,
            style: TextStyles.body02.copyWith(color: AppColors.redError500),
          ),
        ],
      ],
    );
  }
}

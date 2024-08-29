import 'package:class_cloud/common/constants/app_colors.dart';
import 'package:class_cloud/common/utils/utils.dart';
import 'package:class_cloud/core/design_system/text_style.dart';
import 'package:flutter/material.dart';

class CairdioChip extends StatelessWidget {
  const CairdioChip({
    super.key,
    required this.text,
    required this.onTap,
    this.isLoading = false,
    this.style,
    this.backgroundColor = AppColors.primaryColor,
  });

  final String text;
  final TextStyle? style;
  final Color backgroundColor;
  final VoidCallback? onTap;
  final bool isLoading;

  TextStyle get _style {
    return style ??
        TextStyles.body01.copyWith(
          color: AppColors.white100,
        );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : () => onTap?.call(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Chip(
          backgroundColor: backgroundColor,
          label: SizedBox(
            height: 20,
            width: Utils.calculateTextSize(
              text,
              _style,
              MediaQuery.of(context).textScaler,
            ).width,
            child: Center(
              child: isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(),
                    )
                  : Text(
                      text,
                      style: _style,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

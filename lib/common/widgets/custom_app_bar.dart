import 'package:class_cloud/common/constants/app_colors.dart';
import 'package:class_cloud/core/design_system/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.titleStyle,
    this.leadingWidget,
    this.actions = const <Widget>[],
    this.onPressedBack,
    this.showConnectionStatus = false,
    this.bottom,
    this.systemOverlayStyle,
  }) : assert((title != null) ^ (leadingWidget != null));

  final String? title;
  final TextStyle? titleStyle;
  final Widget? leadingWidget;
  final List<Widget> actions;
  final bool showConnectionStatus;
  final VoidCallback? onPressedBack;
  final PreferredSizeWidget? bottom;
  final SystemUiOverlayStyle? systemOverlayStyle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: title == null
          ? null
          : Text(title!, style: titleStyle ?? TextStyles.heading02),
      centerTitle: false,
      systemOverlayStyle: systemOverlayStyle,
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      elevation: 0,
      leading: leadingWidget ??
          IconButton(
            onPressed: () => context.pop(),
            icon:
                const Icon(Icons.arrow_back_ios, color: AppColors.primaryColor),
          ),
      actions: actions,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

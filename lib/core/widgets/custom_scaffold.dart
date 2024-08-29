
import 'package:class_cloud/common/constants/app_colors.dart';
import 'package:class_cloud/features/profile/profile.dart';
import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    required this.content,
    this.backgroundColor = AppColors.primaryColor,
    super.key,
  });

  final Widget content;
  final Color backgroundColor;

  void openDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  void closeDrawer(BuildContext context) {
    Scaffold.of(context).closeDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                color: AppColors.white100,
              ),
              onPressed: () => openDrawer(context),
            );
          },
        ),
      ),
      drawer: Builder(
        builder: (context) {
          return Profile(onPressed: () => closeDrawer(context));
        },
      ),
      backgroundColor: backgroundColor,
      body: content,
    );
  }
}

import 'package:class_cloud/common/constants/app_colors.dart';
import 'package:class_cloud/core/data/school/models/school.dart';
import 'package:class_cloud/core/design_system/design_core.dart';
import 'package:class_cloud/core/design_system/text_style.dart';
import 'package:class_cloud/core/go_router/go_router_keys.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SchoolTile extends StatelessWidget {
  const SchoolTile({required this.school, super.key});

  final School school;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          GoRouterNames.schoolDetails,
          pathParameters: {'schoolId': school.id!},
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
            color: AppColors.grayNeutral100,
            shadowColor: AppColors.blackSnackbarShadow,
            elevation: DesignUnits.x1,
            child: Padding(
              padding: const EdgeInsets.all(DesignUnits.x2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SchoolTileName(name: school.name!),
                  const SizedBox(height: DesignUnits.x2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SchoolTileName extends StatelessWidget {
  const _SchoolTileName({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 8),
        Text(
          name,
          style: TextStyles.heading03,
          textAlign: TextAlign.start,
          overflow: TextOverflow.clip,
          maxLines: 1,
        ),
      ],
    );
  }
}

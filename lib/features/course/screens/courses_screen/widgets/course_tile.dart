import 'package:class_cloud/common/constants/app_colors.dart';
import 'package:class_cloud/core/data/course/model/course.dart';
import 'package:class_cloud/core/design_system/design_core.dart';
import 'package:class_cloud/core/design_system/text_style.dart';
import 'package:class_cloud/core/go_router/go_router_keys.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CourseTile extends StatelessWidget {
  const CourseTile({required this.course, super.key});

  final Course course;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          GoRouterNames.courseDetails,
          pathParameters: {'courseId': course.id!},
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
                  _CourseTileName(name: course.id!),
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

class _CourseTileName extends StatelessWidget {
  const _CourseTileName({required this.name});

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

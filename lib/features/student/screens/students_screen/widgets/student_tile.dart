import 'package:class_cloud/common/constants/app_colors.dart';
import 'package:class_cloud/core/data/students/models/student.dart';
import 'package:class_cloud/core/design_system/design_core.dart';
import 'package:class_cloud/core/design_system/text_style.dart';
import 'package:class_cloud/core/go_router/go_router_keys.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StudentTile extends StatelessWidget {
  const StudentTile({required this.student, super.key});

  final Student student;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          GoRouterNames.studentDetails,
          pathParameters: {'studentId': student.id},
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
                  _StudentTileName(name: student.firstName),
                  const SizedBox(height: DesignUnits.x2),
                  // _StudentTileEmail(email: student.email),
                  // const SizedBox(height: DesignUnits.x2),
                  // _ViewMoreBtn(studentId: student.id),
                  // const SizedBox(height: DesignUnits.x4),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StudentTileName extends StatelessWidget {
  const _StudentTileName({required this.name});

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

class _StudentTileEmail extends StatelessWidget {
  const _StudentTileEmail({required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 8),
        Text(
          email,
          style: TextStyles.heading03,
        ),
      ],
    );
  }
}

class _ViewMoreBtn extends StatelessWidget {
  const _ViewMoreBtn({required this.studentId});

  final String studentId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          GoRouterNames.studentDetails,
          pathParameters: {'studentId': studentId},
        );
      },
      child: Text(
        'View more...',
        style: TextStyles.heading03.copyWith(
          color: AppColors.blueLink,
        ),
      ),
    );
  }
}

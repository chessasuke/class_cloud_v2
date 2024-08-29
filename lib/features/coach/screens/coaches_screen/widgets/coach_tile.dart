import 'package:class_cloud/common/constants/app_colors.dart';
import 'package:class_cloud/core/data/coaches/models/coach.dart';
import 'package:class_cloud/core/design_system/design_core.dart';
import 'package:class_cloud/core/design_system/text_style.dart';
import 'package:class_cloud/core/go_router/go_router_keys.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CoachTile extends StatelessWidget {
  const CoachTile({required this.coach, super.key});

  final Coach coach;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          GoRouterNames.coachDetails,
          pathParameters: {'coachId': coach.id},
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
                  _CoachTileName(name: coach.firstName),
                  // const SizedBox(height: DesignUnits.x2),
                  // _CoachTileEmail(email: coach.email),
                  // const SizedBox(height: DesignUnits.x2),
                  // _ViewMoreBtn(coachId: coach.id),
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

class _CoachTileName extends StatelessWidget {
  const _CoachTileName({required this.name});

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

class _CoachTileEmail extends StatelessWidget {
  const _CoachTileEmail({required this.email});

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
  const _ViewMoreBtn({required this.coachId});

  final String coachId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          GoRouterNames.coachDetails,
          pathParameters: {'coachId': coachId},
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

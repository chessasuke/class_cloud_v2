import 'package:class_cloud/common/constants/app_colors.dart';
import 'package:flutter/material.dart';

/// Stacks a swipe indicator on top of [child] with [swipeIndicatorToContentPadding] in between.
/// Wraps the column holding the indicator and [child] in padding using the values of [paddingHorizontal], [paddingTop],
/// and [paddingBottom].
class ModalBottomSheetContainer extends StatelessWidget {
  const ModalBottomSheetContainer({
    required this.child,
    this.paddingHorizontal = 20,
    this.paddingTop = 20,
    this.paddingBottom = 20,
    this.swipeIndicatorToContentPadding = 0,
    this.isScrollableOnOverflow = false,
    super.key,
  });

  final Widget child;

  /// Horizontal padding is the same on both sides. Otherwise, the indicator and content would not be centered.
  final double paddingHorizontal;
  final double paddingTop;
  final double paddingBottom;
  final double swipeIndicatorToContentPadding;

  /// If true, the column holding the indicator and [child] is wrapped in a SingleChildScrollView to prevent overflow
  /// errors if the content exceeds the viewport due to a user's large text size setting. The indicator does scroll,
  /// however, which is not ideal UX.
  final bool isScrollableOnOverflow;

  @override
  Widget build(BuildContext context) {
    final Widget mainContent = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SwipeIndicator(),
        SizedBox(height: swipeIndicatorToContentPadding),
        child,
      ],
    );

    return Padding(
      padding: EdgeInsets.fromLTRB(
        paddingHorizontal,
        paddingTop,
        paddingHorizontal,
        paddingBottom,
      ),
      child: isScrollableOnOverflow
          ? SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: mainContent,
            )
          : mainContent,
    );
  }
}

class SwipeIndicator extends StatelessWidget {
  const SwipeIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: AppColors.primaryColor,
      ),
    );
  }
}

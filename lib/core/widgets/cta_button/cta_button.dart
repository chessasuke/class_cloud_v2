import 'package:class_cloud/core/design_system/design_core.dart';
import 'package:class_cloud/core/design_system/text_style.dart';
import 'package:flutter/material.dart';

class CtaButton extends StatefulWidget {
  const CtaButton({
    required this.text,
    this.shouldExpand = true,
    this.isLoading = false,
    this.showContentOnLoading = false,
    this.onPressed,
    super.key,
  });

  final bool isLoading;
  final bool showContentOnLoading;
  final VoidCallback? onPressed;
  final String text;
  final bool shouldExpand;

  @override
  State<CtaButton> createState() => _CtaButtonState();
}

class _CtaButtonState extends State<CtaButton> {
  bool get isEnabled => widget.onPressed != null;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: DesignUnits.maxContainerWidth,
      ),
      height: DesignUnits.x6,
      decoration: BoxDecoration(
        color: isEnabled
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(
          DesignUnits.x1,
        ),
      ),
      child: InkWell(
        customBorder: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(DesignUnits.x1),
          ),
        ),
        onTap: widget.isLoading
            ? null
            : () {
                widget.onPressed?.call();
              },
        child: Row(
          mainAxisSize:
              widget.shouldExpand ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.isLoading && !widget.showContentOnLoading)
              SizedBox(
                height: DesignUnits.x5,
                width: DesignUnits.x5,
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            if (widget.isLoading && widget.showContentOnLoading)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: DesignUnits.x1,
                  vertical: DesignUnits.x1,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      height: DesignUnits.x5,
                      width: DesignUnits.x5,
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    const SizedBox(width: DesignUnits.x2),
                    Text(
                      widget.text,
                      textAlign: TextAlign.center,
                      style: TextStyles.caption01.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            if (!widget.isLoading)
              Text(
                widget.text,
                textAlign: TextAlign.center,
                style: TextStyles.caption01.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

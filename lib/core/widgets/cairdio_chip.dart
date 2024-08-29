import 'package:flutter/material.dart';

typedef OnTap = Future<void> Function();

class CairdioChip extends StatefulWidget {
  const CairdioChip({
    super.key,
    required this.text,
    required this.onTap,
    required this.backgroundColor,
    this.style,
  });

  final String text;
  final TextStyle? style;
  final Color backgroundColor;
  final OnTap? onTap;

  @override
  State<CairdioChip> createState() => _CairdioChipState();
}

class _CairdioChipState extends State<CairdioChip> {
  late bool isLoading;

  // TextStyle get _style {
  //   return widget.style ??
  //       TextStyles.body01.copyWith(
  //         color: AppColors.white100,
  //       );
  // }

  @override
  void initState() {
    super.initState();
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Chip(
        backgroundColor: widget.backgroundColor,
        label: SizedBox(
          height: 25,
          // width: Utils.calculateTextSize(
          //   widget.text,
          //   _style,
          //   MediaQuery.of(context).textScaler,
          // ).width,
          child: Center(
            child: isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(),
                  )
                : GestureDetector(
                    onTap: () async {
                      if (widget.onTap != null) {
                        setState(() {
                          isLoading = true;
                        });
                        await widget.onTap?.call();
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                    child: Text(
                      widget.text,
                      // style: _style,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

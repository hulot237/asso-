import 'package:flutter/material.dart';

class TooltipWidget extends StatelessWidget {
   TooltipWidget({super.key, required this.msg});
  String msg;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: msg,
    );
  }
}
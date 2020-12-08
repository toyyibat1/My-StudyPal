import 'package:flutter/material.dart';

import '../../core/constants.dart';

class TaskTag extends StatelessWidget {
  final Color color;
  final String headText;
  final String text;

  const TaskTag({Key key, this.color, this.headText, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          kExtraSmallVerticalSpacing,
          Text(
            headText,
            style: kLabelText.copyWith(
              fontSize: 16.0,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

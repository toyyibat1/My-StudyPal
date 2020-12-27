import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_study_pal/src/core/constants.dart';

class SignInWithTile extends StatelessWidget {
  final String text;
  final String image;
  final Function ontap;
  const SignInWithTile({Key key, this.image, this.text, this.ontap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Image.asset(
              image,
            ),
            kLargeHorizontalSpacing,
            Text(
              text,
              style: kBodyText1TextStyle,
            ),
          ],
        ),
      ),
    );
  }
}

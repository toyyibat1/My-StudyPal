import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_study_pal/src/core/constants.dart';

class SignInWithTile extends StatelessWidget {
  final String text;
  final String image;
  final Function ontap;
  final bool isLoading;
  const SignInWithTile({Key key, this.image, this.text, this.ontap, this.isLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: isLoading
          ? SizedBox(
              width: 25.0,
              height: 25.0,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            ): Container(
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

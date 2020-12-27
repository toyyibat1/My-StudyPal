import 'package:flutter/material.dart';
import 'package:my_study_pal/src/core/constants.dart';

class AppTile extends StatelessWidget {
  final IconData leading;
  final String title;
  final IconData trailing;
  final Function onPressed;

  const AppTile({
    Key key,
    this.leading,
    @required this.title,
    this.trailing,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFE0E0E0)),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(leading, color: kPrimaryColor) ?? Container(),
            leading == null ? Container() : SizedBox(width: 24),
            Container(
              width: MediaQuery.of(context).size.width * 0.66,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Spacer(),
            Icon(trailing, color: Color(0xFFE0E0E0)) ?? Container(),
          ],
        ),
      ),
    );
  }
}

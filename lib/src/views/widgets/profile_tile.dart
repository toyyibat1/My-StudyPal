import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  final Widget leading;
  final String title;
  final String email;
  final IconData trailing;
  final Function onPressed;

  const ProfileTile({
    Key key,
    this.email,
    @required this.leading,
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
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            leading,
            SizedBox(width: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                email == null ? Container() : SizedBox(height: 8),
                email == null
                    ? Container()
                    : Text(
                        email,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

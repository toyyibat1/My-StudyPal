import 'package:flutter/material.dart';

class AppFlatButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final String image;

  const AppFlatButton({
    this.onPressed,
    this.text,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      child: FlatButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: Colors.blue)),
        child: Row(
          children: [
            Image.asset(image),
            SizedBox(
              width: 40,
            ),
            Text(
              text,
              style: TextStyle(fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}

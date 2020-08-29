import 'package:FarmApp/Models/Constants.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final onPressedCallBack;
  final String text;
  final Color color;

  MyButton({this.onPressedCallBack, this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(right: 10.0),
        child: Container(
          child: RaisedButton(
            child: Text(text),
            textColor: Colors.white,
            color: color,
            onPressed: onPressedCallBack,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
      ),
      flex: 2,
    );
  }
}

class MyIcon extends StatelessWidget {
  final onTapCallBack;
  final double radius;
  final IconData iconData;
  final double size;

  MyIcon({this.onTapCallBack, this.radius, this.iconData, this.size = 25.0});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: CircleAvatar(
        backgroundColor: Color(APP_COLOR),
        radius: radius,
        child: Icon(
          iconData,
          color: Colors.white,
          size: size,
        ),
      ),
      onTap: onTapCallBack,
    );
  }
}

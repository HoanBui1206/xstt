import 'dart:ui';

import 'package:flutter/material.dart';

const Color primarya500 = Color(0xFF2F6BFF);
const Color ink200 = Color(0x1A011222);
const Color ink500 = Color(0xFF22313F);

final TextStyle t16M = TextStyle(
  color: Colors.white,
  fontSize: 16,
  height: 24 / 16,
  fontWeight: FontWeight.w500,
);

final TextStyle t24M = TextStyle(
  color: Colors.white,
  fontSize: 24,
  height: 24 / 16,
  fontWeight: FontWeight.w500,
);

final TextStyle t32M = TextStyle(
  color: Colors.white,
  fontSize: 32,
  height: 24 / 16,
  fontWeight: FontWeight.w500,
);

class Button extends StatelessWidget {
  final String text;
  final Function onClicked;
  final Color color;
  final Widget icon;
  Button({
    @required this.text,
    this.onClicked,
    this.color,
    this.icon,
  });
  @override
  Widget build(BuildContext context) {
    return Material(
      color: color ?? primarya500,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: this.onClicked ?? () {},
        splashColor: ink200,
        highlightColor: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              children: [
                widgetText(),
                Container(
                  height: 48,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [this.icon ?? Container()],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget widgetText() {
    return Container(
      height: 48,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$text',
            maxLines: 1,
            style: t16M,
          ),
        ],
      ),
    );
  }
}

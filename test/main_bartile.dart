import 'package:flutter/material.dart';

class MainBarTile extends StatelessWidget {
  double _duration = 3.0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedContainer(
          margin: EdgeInsets.only(
              left: (MediaQuery.of(context).size.width) / 12 * 1),
          width: (MediaQuery.of(context).size.width),
          height: MediaQuery.of(context).size.height / 25,
          //color: Colors.amber,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
          duration: Duration(milliseconds: 1000),
          curve: Curves.fastOutSlowIn,
        ),
        AnimatedContainer(
          margin: EdgeInsets.only(
              left: (MediaQuery.of(context).size.width) / 12 * 1),
          width: (MediaQuery.of(context).size.width) / 12 * _duration,
          height: MediaQuery.of(context).size.height / 25,
          //color: Colors.amber,
          decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.circular(2.0)),
          duration: Duration(milliseconds: 1000),
          curve: Curves.fastOutSlowIn,
        ),
      ],
    );
  }
}

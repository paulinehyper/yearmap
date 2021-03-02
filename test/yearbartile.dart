import 'package:flutter/material.dart';

//not using! 2021.02.24
class YearBarTile extends StatelessWidget {
  double _duration = 1;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 200,
          left: 150,
          child: AnimatedContainer(
            width: (MediaQuery.of(context).size.width) / 12 * _duration,
            height: MediaQuery.of(context).size.height / 30,
            //color: Colors.amber,
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(3.0)),
            duration: Duration(milliseconds: 1000),
            curve: Curves.fastOutSlowIn,
          ),
        ),
      ],
    );

    // height: MediaQuery.of(context).size.height / 25,
    // height: ,
    // width: (MediaQuery.of(context).size.width) / 12 * _duration,
    //child: BoxDecoration(borderRadius: BorderRadius.circular(10.0),color: Colors.amber),
    //color: Colors.green,
  }
}

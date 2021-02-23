import 'package:flutter/material.dart';
import 'package:yearmap/widget/yearbartile.dart';

//2021.02.23
class MainDeco extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _calendariconWidth = MediaQuery.of(context).size.width / 13;
    double _fontSize = _calendariconWidth / 2.8;

    return Stack(
      children: [
        Positioned(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (int i = 0; i < 12; i++)
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Image.asset(
                      'assets/images/cals.png',
                      width: _calendariconWidth,
                    ),
                    Text(
                      '\n${i + 1}',
                      style:
                          TextStyle(color: Colors.white, fontSize: _fontSize),
                    ),
                  ],
                )
            ],
          ),
        ),
        Positioned(
          child: YearBarTile(),
          top: 100,
          left: 100 + MediaQuery.of(context).size.width / 13 * 10,
        )
      ],
    )

        /*
        Positioned(
          child: AnimatedContainer(
            width: (MediaQuery.of(context).size.width) / 12 * 4,
            height: MediaQuery.of(context).size.height / 25,
            //color: Colors.amber,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(10.0)),
            duration: Duration(milliseconds: 500),
          ),
          top: 60,
          left: 100,
          //start: 100,

          // height: MediaQuery.of(context).size.height / 25,
          // height: ,
          // width: (MediaQuery.of(context).size.width) / 12 * _duration,
          //child: BoxDecoration(borderRadius: BorderRadius.circular(10.0),color: Colors.amber),
          //color: Colors.pink,
        )*/

        ;
  }
}

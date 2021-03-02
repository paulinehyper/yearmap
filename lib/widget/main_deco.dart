import 'package:flutter/material.dart';
import 'file:///Users/paulinekoh/workspace/yearmap/test/yearbartile.dart';

//2021.02.23
class MainDeco extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _calendariconWidth = MediaQuery.of(context).size.width / 13;
    double _fromNowCalendarWidth = _calendariconWidth;
    double _pastCalendarWidth = _fromNowCalendarWidth * 1.0;

    double _fontSize = _calendariconWidth / 2.8;

    DateTime _nowDateTime = DateTime.now();
    int _monthNow = _nowDateTime.month;

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
                    _monthNow <= (i + 1)
                        ? Image.asset(
                            'assets/images/cali.png',
                            fit: BoxFit.contain,
                            width: _fromNowCalendarWidth,
                          )
                        : Image.asset(
                            'assets/images/unselectedcali.png',
                            width: _pastCalendarWidth,
                          ),
                    Text(
                      '\n${i + 1}',
                      style: _monthNow > (i + 1)
                          ? TextStyle(
                              color: Colors.white54, fontSize: _fontSize * 0.9)
                          : TextStyle(color: Colors.white, fontSize: _fontSize),
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
    );
  }
}

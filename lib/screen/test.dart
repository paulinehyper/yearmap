import 'dart:math';

import 'package:flutter/material.dart';
import 'package:yearmap/widget/calendar_headar.dart';
import 'package:yearmap/widget/main_bartile.dart';
import 'package:yearmap/widget/main_deco.dart';
import 'package:yearmap/widget/yearbartile.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  Color _color = Colors.black;
  bool _visible = true;
  double projectduration = 2.0;
  double _startdate;
  double _enddate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () {
          setState(() {
            _visible = !_visible;
            final random = Random();
            _color = Color.fromRGBO(random.nextInt(256), random.nextInt(256),
                random.nextInt(256), 1);
          });
        }),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MainDeco(),
            SizedBox(
              height: 30,
            ),
            _projectTile(context, projectduration, 'projectNmaefortile'),
          ],
        )
        //MainDeco(), YearBarTile()

        /*
      Stack(
        children: [
          Positioned(
            child: MainDeco(),
            top: 10,
            left: 10,
          ),
          Positioned(
            child: YearBarTile(),
            top: 100,
            left: 10 + MediaQuery.of(context).size.width / 13 * 10,
          )
        ],
      ),
*/
        // YearBarTile()

        /*
        Column(
          //mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
            ),
            MainDeco(),
            SizedBox(
              height: 30,
            ),
            // ignore: missing_required_param
            YearBarTile()
          ],
        )*/
        // calendarHeader(),
        //stack position의 경우, 위젯을 덮어씌우면 위치를 잃어버리기 떄문에 에러!!
        );
  }

  Stack _projectTile(
      BuildContext context, double duration, String projectName) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        _mainTile(context, duration),
        Text(
          projectName,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Stack _mainTile(BuildContext context, double duration) {
    double _duration = duration;
    return Stack(
      children: [
        AnimatedContainer(
          margin: EdgeInsets.only(
              left: (MediaQuery.of(context).size.width) / 12 * 1),
          width: (MediaQuery.of(context).size.width),
          height: MediaQuery.of(context).size.height / 25,
          //color: Colors.amber,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(2.0)),
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
              color: Colors.pink[100],
              borderRadius: BorderRadius.circular(2.0)),
          duration: Duration(milliseconds: 1000),
          curve: Curves.fastOutSlowIn,
        ),
      ],
    );
  }
}

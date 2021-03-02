import 'dart:math';

import 'package:flutter/material.dart';
import 'package:yearmap/model/project_info.dart';
import 'file:///Users/paulinekoh/workspace/yearmap/test/calendar_headar.dart';
import 'file:///Users/paulinekoh/workspace/yearmap/test/main_bartile.dart';
import 'package:yearmap/widget/main_deco.dart';
import 'package:yearmap/widget/project_bar.dart';
import 'file:///Users/paulinekoh/workspace/yearmap/test/yearbartile.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  Color _color = Colors.black;
  bool _visible = true;
  double projectduration = 2.0; //input 변수..나중에 설정하자 db만들고!
  String projectname;
  int _startday;
  int _startyear;
  int _startmonth;
  int _endyear;
  int _endmonth;
  int _endday;
  int _duration;

  DateTime _dateTime;
  int _yearNow;
  int _monthNow;
  int _dayNow;

  List<ProjectInfo> _projectInfo = [
    ProjectInfo.fromMap({
      'projectname': 'cali app 만들기',
      'startyear': 2021,
      'startmonth': 2,
      'startday': 28,
      'endyear': 2021,
      'endmonth': 6,
      'endday': 30,
    }),
    ProjectInfo.fromMap({
      'projectname': 'cali app 만들기',
      'startyear': 2021,
      'startmonth': 3,
      'startday': 28,
      'endyear': 2021,
      'endmonth': 12,
      'endday': 30,
    })
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _dateTime = DateTime.now();
    // _monthNow = _dateTime.month;
    // _dayNow = _dateTime.day;
    // _yearNow = _dateTime.year;
  }

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
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start, //이걸 없애면 컬럼이 중앙정렬. 조심.
          children: [
            MainDeco(), //calendars row
            SizedBox(
              height: 30,
            ),

            ProjectBar(
              projectInfo: _projectInfo,
            ),
          ],
        )

        //stack position의 경우, 위젯을 덮어씌우면 위치를 잃어버리기 떄문에 에러!!
        );
  }
/*
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
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(2.0)),
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
  }*/
}

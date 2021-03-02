import 'package:flutter/material.dart';
import 'package:yearmap/model/project_info.dart';

class ProjectBar extends StatefulWidget {
  final List<ProjectInfo> projectInfo;
  ProjectBar({this.projectInfo});
  @override
  _ProjectBarState createState() => _ProjectBarState();
}

class _ProjectBarState extends State<ProjectBar> {
  List<ProjectInfo> projectInfo;

  List<String> projectname;
  List<int> startmonth;
  List<int> endmonth;
  List<int> duration;

  int monthnow = DateTime.now().month;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    projectInfo = widget.projectInfo;
    projectname = projectInfo.map((e) => e.projectname).toList();
    startmonth = projectInfo.map((e) => e.startmonth).toList();
    endmonth = projectInfo.map((e) => e.endmonth).toList();
    duration = projectInfo.map((e) => e.duration).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      //mainAxisAlignment: MainAxisAlignment.start,
      children: barchart(projectInfo: projectInfo, context: context),
    );
  }

  List<Widget> barchart({List<ProjectInfo> projectInfo, BuildContext context}) {
    List<Widget> results = [];

    for (var i = 0; i < projectInfo.length; i++) {
      results
          .add(Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 30,
        ),
        Text(projectname[i]),
        Stack(
          children: [
            AnimatedContainer(
              margin: EdgeInsets.only(
                  left: (MediaQuery.of(context).size.width) /
                      12 *
                      (startmonth[i] - 1)), //시작점. padding 이용.
              width: (MediaQuery.of(context).size.width) /
                  12.5 *
                  (duration[i] + 1),
              height: MediaQuery.of(context).size.height / 30,
              //color: Colors.amber,
              decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(20.0)),
              duration: Duration(milliseconds: 1000),
              curve: Curves.fastOutSlowIn,
            ),
            AnimatedContainer(
              margin: EdgeInsets.only(
                  left: (MediaQuery.of(context).size.width) /
                      12 *
                      (startmonth[0] - 1)),
              width: monthnow > startmonth[i]
                  ? (MediaQuery.of(context).size.width) /
                      12.5 *
                      (monthnow - startmonth[i] + 0.5)
                  : (MediaQuery.of(context).size.width) / 12.5 * (0),
              height: MediaQuery.of(context).size.height / 30,
              //color: Colors.amber,
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(20.0)),
              duration: Duration(milliseconds: 1000),
              curve: Curves.fastOutSlowIn,
            ),
          ],
        ),
      ]));
    }
    return results;
  }
}

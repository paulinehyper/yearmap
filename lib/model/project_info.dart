class ProjectInfo {
  final int startyear;
  final int startmonth;
  final int startday;

  final int endyear;
  final int endmonth;
  final int endday;

  final int duration;

  final String projectname;

  ProjectInfo.fromMap(Map<String, dynamic> map)
      : startyear = map['startyear'],
        startmonth = map['startmonth'],
        startday = map['startday'],
        endyear = map['endyear'],
        endmonth = map['endmonth'],
        endday = map['endday'],
        projectname = map['projectname'],
        duration = map['endmonth'] - map['startmonth'];
}

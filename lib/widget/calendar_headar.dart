import 'package:flutter/material.dart';

class calendarHeader extends StatelessWidget {
  const calendarHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _calendarWidth = MediaQuery.of(context).size.width / 12;
    double _gap_calendars = _calendarWidth;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SafeArea(
        child: Stack(alignment: Alignment.topLeft, children: [
          for (int i = 0; i < 12; i++)
            Positioned(
                //bottom: 10,
                top: 10,
                left: 0.0 + i * (_gap_calendars * 1.2),
                child: Image.asset(
                  'assets/images/cals.png',
                  width: _calendarWidth,

                  //scale: (_calendarWidth * 1.1)
                  // MediaQuery.of(context).size.width / 12
                  //36,
                )),
          for (int i = 0; i < 12; i++)
            Positioned(
              //bottom: 10,
              top: 20,
              left: 10.0 + i * _gap_calendars * 0.9,
              //29.8,

              child: Text(
                '${i + 1}',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          Positioned(
            child: AnimatedContainer(
              width: MediaQuery.of(context).size.width * 0.7,
              height: 30,
              //color: Colors.amber,
              decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(10.0)),
              duration: Duration(milliseconds: 500),
            ),
            top: 100,
          )
        ]),
      ),
    );
  }
}

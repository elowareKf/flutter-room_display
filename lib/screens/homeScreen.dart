import 'package:flutter/material.dart';
import 'package:room_display/services/RestAPIClient.dart';

import '../models/mainDisplayInfo.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() {
    return new HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  MainDisplayInfo _data;

  HomeScreenState() {
    _data = new MainDisplayInfo();
    _data.roomName = "Room";
    _data.appointmentDate = "01.01.2019";
    _data.appointmentTime = "10:00";
    _data.appointmentText = "Besprechung mit Flutter";
    _data.appointmentOrganizer = "Klaus Fischer";
    _data.a1Time = "04.01.2019 - 10:00";
    _data.a1Text = "Nächster Termin";
    _data.a2Time = "05.01.2019 - 10:00";
    _data.a2Text = "Übernächster Termin";
    _data.newsTicker = "Newsticker....";
  }

  @override
  void initState() {
    super.initState();

    return; 
    RestAPIClient().getData().then((data) {
      setState(() {
        _data = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var columnWidths = new Map<int, TableColumnWidth>();
    columnWidths.addAll(
      {
        0: FlexColumnWidth(1.0),
        1: FlexColumnWidth(3.0)
      }
    );

    return Scaffold(
        body: Container(
            constraints: BoxConstraints.expand(),
            child: Stack(
              children: <Widget>[
                Table(
                  columnWidths: columnWidths,
                  children: <TableRow>[
                  TableRow(
                    children: <Widget>[
                    TableCell(
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () => print("Open settings panel"),
                            child: Text(_data.roomName),
                          ),
                          Text(_data.appointmentDate),
                        ],
                      ),
                    ),
                    TableCell(
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () => print("Open arming panel"),
                            child: Text(_data.alarmSystemText),
                          ),
                        ],
                      ),
                    ),
                  ]),
                  TableRow(children: <Widget>[
                    TableCell(
                      child: Container(
                        height: 300,
                        alignment: Alignment.center,
                        child: Text(_data.appointmentTime,
                            style: TextStyle(
                                color: Colors.red[900],
                                fontSize: 40,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.fill,
                      child: Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              _data.appointmentText,
                              style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(_data.appointmentOrganizer),
                          ],
                        ),
                      ),
                    ),
                  ]),
                  TableRow(children: <Widget>[
                    TableCell(
                      child: Text(_data.nextAppointmentsHeadline,
                      style: TextStyle(
                          fontWeight: FontWeight.w600
                      )),
                    ),
                    TableCell(
                      child: Container(),
                    ),
                  ]),
                  TableRow(children: <Widget>[
                    TableCell(
                      child: Text(_data.a1Time),
                    ),
                    TableCell(
                      child: Text(_data.a1Text),
                    ),
                  ]),
                  TableRow(children: <Widget>[
                    TableCell(
                      child: Text(_data.a2Time),
                    ),
                    TableCell(
                      child: Text(_data.a2Text),
                    ),
                  ]),
                ]),
                Container(
                  alignment: AlignmentDirectional.bottomStart,
                  child: Text(_data.newsTicker),
                ),
              ],
            )));
  }
}

/*
          Row(
            children: <Widget>[],
          ),
          Row(
            children: <Widget>[
              Text("10:00"),
              Text("How to Mock an API..."),
            ],
          ),
          Row(
            children: <Widget>[
              Text("Nächste Termine"),
            ],
          ),
          Row(
            children: <Widget>[
              Text("04.01.2019 - 11:30"),
              Text("04.01.2019 - 13:30"),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text("How to Mock an API..."),
              Text("How to Mock an API..."),
              Text("How to Mock an API..."),
              Text("How to Mock an API..."),
            ],
*/

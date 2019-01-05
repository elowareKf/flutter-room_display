import 'package:date_format/date_format.dart';

class MainDisplayInfo {
  String roomName;

  String appointmentText;
  String appointmentOrganizer;
  String appointmentDate;
  String appointmentTime;

  String nextAppointmentsHeadline = "Nächste Termine";
  String alarmSystemText = "Alarmanlage";

  String a1Time;
  String a1Text;
  String a2Time;
  String a2Text;

  MainDisplayInfo();

  String formateFullDate(DateTime date) =>
      formatDate(date, [dd, '.', mm, '.', yyyy, ' - ', HH, ':', nn]);

  MainDisplayInfo.fromJson(jsonData) {
    try {
      List<dynamic> rawData = jsonData as List<dynamic>;

      if (rawData.length > 0) {
        var date = DateTime.parse(rawData[0]["start"]).toLocal();

        appointmentText = (rawData[0]["subject"] as String) ?? "";
        appointmentOrganizer = (rawData[0]["organizer"] as String) ?? "";
        appointmentDate = formatDate(date, [dd, '.', mm, '.', yyyy]);
        appointmentTime = formatDate(date, [HH, ':', nn]);
      }
      else{
        appointmentText = "Raum frei";
        appointmentDate = "";
        appointmentOrganizer = "";
        appointmentTime ="";
      }

      if (rawData.length > 1) {
        nextAppointmentsHeadline = "Nächste Termine";
        var date = DateTime.parse(rawData[1]["start"] as String).toLocal();
        a1Time = formateFullDate(date);
        a1Text = (rawData[1]["subject"] as String) ?? "";
      } else {
        nextAppointmentsHeadline = "";
        a1Text = "";
        a1Time = "";
      }

      if (rawData.length > 2) {
        var date = DateTime.parse(rawData[2]["start"] as String).toLocal();
        a2Time = formateFullDate(date);
        a2Text = (rawData[2]["subject"] as String) ?? "";
      } else {
        a2Text = "";
        a2Time = "";
      }
    } catch (exception) {
      print(exception);
    }
  }
}

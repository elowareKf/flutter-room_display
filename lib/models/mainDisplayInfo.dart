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

  String newsTicker;

  MainDisplayInfo();

  MainDisplayInfo.fromJson(jsonData) {
    try {
      roomName = (jsonData["RoomName"] as String) ?? "";
      appointmentText = (jsonData["Subject"] as String) ?? "";
      appointmentOrganizer = (jsonData["Organizer"] as String) ?? "";
      appointmentDate = formatDate(DateTime.now(), [dd,'.',mm,'.',yyyy]); //(jsonData[""] as String) ?? "";
      appointmentTime = (jsonData["StartTime"] as String) ?? "";
      a1Time = (jsonData["NextStart"] as String) ?? "";
      a1Text = (jsonData["NextShortForm"] as String) ?? "";
      a2Time = (jsonData["NextPStart"] as String) ?? "";
      a2Text = (jsonData["NextPShortForm"] as String) ?? "";
      newsTicker = (jsonData[""] as String) ?? "";
    } catch (exception) {
      print(exception);
    }
  }
}

import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // location name for the UI
  String? time; // the time in that location
  String flag; // url to an asset flag icon
  String url; // location url for api endpoint
  late bool isDayTime;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      Response response = await get(Uri.parse(
          "http://worldtimeapi.org/api/timezone/$url")); // setting our url
      Map data = jsonDecode(response.body);

      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      //set the time and daytime property
      if (now.hour > 6 && now.hour < 18) {
        isDayTime = true;
      } else {
        isDayTime = false;
      }
      time = DateFormat.jm().format(now);
    } catch (e) {
      print("caught error $e");
      time = 'could not get time';
    }
  }
}
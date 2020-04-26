import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  
  String location;
  String time;
  String flag;
  String url; //location url for api endpoint
  bool isDayTime;

  WorldTime({this.location, this.url, this.flag});

  Future<void> getTime() async {

    try {
      Response response = await get("http://worldtimeapi.org/api/timezone/$url");
    Map data = jsonDecode(response.body);
    
    String datetime = data["datetime"];
    String offset = data["utc_offset"];
    
    String symbol = offset.substring(0,1);
    String hours = offset.substring(1,3);
    String minutes = offset.substring(4,6);

    //create a datatime object
    DateTime now = DateTime.parse(datetime);
    if(symbol == "+") {
      now = now.add(Duration(hours: int.parse(hours), minutes: int.parse(minutes)));
    }
    else {
      now = now.subtract(Duration(hours: int.parse(hours), minutes: int.parse(minutes)));
    }
    
    // set time property
    isDayTime = now.hour > 6 && now.hour < 19 ? true : false;
    time = DateFormat.jm().format(now);
    }
    catch (e) {
      print("catch $e");
      time = "Could not get time";
    }
    
  }

}


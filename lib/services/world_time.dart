import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WorldTime{
  String location;
  String time='';
  String flag;
  String url;
  bool isDayTime=false;
  WorldTime({required this.location, required this.flag, required this.url});
  Future<void> getTime() async {
    try {
      // Correct way to parse URL
    var url1 = Uri.parse('https://worldtimeapi.org/api/timezone/$url');
    
    // Await for the response from the API
    http.Response response = await http.get(url1);
    
    // Decode the response body
    Map data = jsonDecode(response.body);
    
    // Access the 'datetime' key
    String dateTime = data['datetime'];
    String offset =data['utc_offset'].substring(1,3);
    
    // Parse the datetime string into a DateTime object
    DateTime now = DateTime.parse(dateTime);
    now=now.add(Duration(hours: int.parse(offset)));
    time=DateFormat.jm().format(now);
    isDayTime= (now.hour>6 &&now.hour<18) ?true: false;
    } catch (e) {
      print('caught error $e');
      time='could not get the time';
    }
  }
  }
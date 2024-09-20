import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        data.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments;
    if (routeArgs != null && routeArgs is Map) {
      data = routeArgs; // Safely cast the arguments to Map
    }

    String bgImage = data['isDayTime'] ? 'day.png' : 'night.png';
    Color? bgColor = data['isDayTime'] ? Colors.blue : Colors.indigo[500];
    Color? fontColor = data['isDayTime'] ? Colors.black : Colors.white;
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/$bgImage'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            GestureDetector(
                onTap: () async {
                  dynamic result = await Navigator.pushNamed(context, '/location');
                  setState(() {
                    data = {
                      'time': result['time'],
                      'url': result['url'],
                      'location': result['location'],
                      'flag': result['flag'],
                      'isDayTime': result['isDayTime'],
                    };
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.edit_location),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "Edit Location",
                        style: TextStyle(
                          color: fontColor,
                        ),
                      )
                    ],
                  ),
                )),
            SizedBox(
              height: 20.0,
            ),
            Text(
              data['location'],
              style: TextStyle(
                fontSize: 28.0,
                letterSpacing: 2.0,
                color: fontColor,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              data['time'],
              style: TextStyle(
                fontSize: 66.0,
                letterSpacing: 2.0,
                color: fontColor,
              ),
            ),
          ],
        ),
      )),
    );
  }
}

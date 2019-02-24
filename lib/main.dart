import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'dart:math';



void main() => runApp(MyApp());
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double _direction;
  var location = new Location();
  var waypoint = [[40.0099, -105.243], [40.101, -105.243], [40.101,-105.753], [40.0099, -105.753], [40.0099,-105.243]];
  var cnt = 0;
  @override
  void initState() {
    super.initState();
    
    location.onLocationChanged().listen((Map<String,double> currentLocation) {
       setState(() {
        double angle =angleFromCoordinate(currentLocation["latitude"], currentLocation["longitude"], waypoint[cnt][0], waypoint[cnt][1]);
        _direction = angle;
        cnt = (cnt +1)%5;
         });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Find Your Adventure'),
        ),
        body: new Container(
          alignment: Alignment.center,
          color: Colors.black,
          child: new Transform.rotate(
            angle: (_direction * -1),
            child: new Image.asset('assets/compass.jpg'),
          ),
        ),
      ),
    );
  }
  double angleFromCoordinate(double lat1, double long1, double lat2,
        double long2) {
    double dLon = (long2 - long1);
    double y = sin(dLon) * cos(lat2);
    double x = cos(lat1) * sin(lat2) - sin(lat1)
            * cos(lat2) * cos(dLon);
    double brng = atan2(y, x);
    brng = brng*180/pi;
    brng = (brng + 360) % 360;
    brng = 360 - brng; // count degrees counter-clockwise - remove to make clockwise
    //print("THIS IS THE BRNG");
    //print(brng);
    return brng;
}
}
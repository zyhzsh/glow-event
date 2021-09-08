import 'package:flutter/material.dart';
import 'package:location/location.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glow 2021',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Welcome to Glow 2021'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Location location = new Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;
  bool _isListenLocation = false, _isGetLocation=false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body:Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () async{
                _serviceEnabled = await location.serviceEnabled();
                if(!_serviceEnabled) {
                  _serviceEnabled = await location.requestService();
                  if(_serviceEnabled) return;
                }

                _permissionGranted = await location.hasPermission();
                if(_permissionGranted == PermissionStatus.denied) {
                  _permissionGranted = await location.requestPermission();
                  if(_permissionGranted != PermissionStatus.granted) return;
                }

                _locationData = await location.getLocation();
                setState(() {
                  _isGetLocation = true;
                });

              }, child: Text('Get Location')),
              _isGetLocation ? Text('Location: ${_locationData.latitude} / ${_locationData.longitude}') : Container(),
              ElevatedButton(onPressed: () async {
                _serviceEnabled = await location.serviceEnabled();
                if(!_serviceEnabled) {
                  _serviceEnabled = await location.requestService();
                  if(_serviceEnabled) return;
                }

                _permissionGranted = await location.hasPermission();
                if(_permissionGranted == PermissionStatus.denied) {
                  _permissionGranted = await location.requestPermission();
                  if(_permissionGranted != PermissionStatus.granted) return;
                }
                setState(() {
                  _isListenLocation = true;
                });
              }, child: Text('Listen Location')),
              StreamBuilder(
                  stream: location.onLocationChanged,
                  builder: (context,snapshot){
                    if(snapshot.connectionState != ConnectionState.waiting)
                    {
                      var data = snapshot.data as LocationData;
                      return Text('Location always change: \n ${data.latitude}/${data.longitude}');
                    }
                    else return Center(child: CircularProgressIndicator(),);
                  })

            ],
          )
      ),

    );
  }
}

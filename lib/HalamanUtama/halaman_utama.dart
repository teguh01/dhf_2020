import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:dhf_2020/HalamanUtama/sensor.dart';
import '../Login/auth_services.dart';
import 'sensor.dart';

Future<SensorAlat> fetchSensor() async {
  final response = await http.get(
      'https://platform.antares.id:8443/~/antares-cse/antares-id/smartPestisida/esp32_dhf_2020/la',
       headers: {"X-M2M-Origin": "3d65eb3a72a7d964:6af31b96efd74987",
                "Content-Type": "application/json;ty=4",
                "Accept": "application/json", 
      }
    );
  if (response.statusCode == 200) {
    print(json.decode(response.body));
    print("berhasil");
    return SensorAlat.fromJson(json.decode(response.body));
  } else {
    print("gagal");
    throw Exception('Failed to load album');
  }
}

class Monitoring extends StatefulWidget {
  @override
  _MonitoringState createState() => _MonitoringState();
}

class _MonitoringState extends State<Monitoring> {
  Future<SensorAlat> futureSensor;

  setUpTimedFetch() {
    Timer.periodic(Duration(milliseconds: 5000), (timer) {
      setState(() {
        futureSensor = fetchSensor();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    setUpTimedFetch();
    futureSensor = fetchSensor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.green,
        title: new Text("Smart Pestisida"),
        actions: <Widget>[
          IconButton(
            onPressed: ()async{
                await AuthServices.signOut();
              },
            icon: Icon(Icons.lock_open),
          ),
        ],
        ),
      body: Center(
        child: FutureBuilder<SensorAlat>(
          future: futureSensor,
          builder: (context, snapshot) {
            if(snapshot.hasData){
              String data = snapshot.data.lahan;
              var splitData = data.split(",");
              var day = splitData[0];
              var daySplit = day.split(":");
              var hari = daySplit[1].replaceAll('"', '');
              var time = splitData[1];
              var timeSplit = time.split(":");
              var jam = timeSplit[1].replaceAll('"', '');
              var tmp = splitData[2].split(":");
              var hum = splitData[3].split(":");
              var wind = splitData[4].split(":");
              var hujan = splitData[5].split(":");
              var kondisi = hujan[1].replaceAll('"', '');
              var air = splitData[6].split(":");
              var bio = splitData[7].split(":");
              var pump = splitData[8].split(":");
              var mesinbio = pump[1].replaceAll('"', '');
              var msn = splitData[9].split(":");
              var mesinair = msn[1].replaceAll('"', '');
              var otoBio = splitData[10].split(":");
              var otomatisBio = otoBio[1].replaceAll('"', '');
              var otoair = splitData[11].split(":");
              var otomatisair = otoair[1].replaceAll('"', '').replaceAll('}', '');
              // print(time);
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Card(
                            color: Colors.greenAccent,
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.wb_sunny, size: 45),
                                  Text("Hari"),
                                  Text(hari),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            color: Colors.greenAccent,
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.access_time, size: 45),
                                  Text("Jam"),
                                  Text(jam)
                                ],
                              ),
                            ),
                          ),
                          Card(
                            color: Colors.greenAccent,
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.ac_unit,size: 45),
                                  Text("Suhu"),
                                  Text("${tmp[1]} *C")
                                ],
                              ),
                            ),
                          ),   
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Card(
                            color: Colors.greenAccent,
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.whatshot, size: 45),
                                  Text("Hum"),
                                  Text("${hum[1]} %")
                                ],
                              ),
                            ),
                          ),
                          Card(
                            color: Colors.greenAccent,
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.toys, size: 45),
                                  Text("Wind"),
                                  Text("${wind[1]} Km/h")
                                ],
                              ),
                            ),
                          ),
                          Card(
                            color: Colors.greenAccent,
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.invert_colors, size: 45),
                                  Text("Cuaca"),
                                  Text(kondisi)
                                ],
                              ),
                            ),
                          ),   
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Card(
                            color: Colors.greenAccent,
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.opacity, size: 45),
                                  Text("Air"),
                                  Text("${air[1]}")
                                ],
                              ),
                            ),
                          ),
                          Card(
                            color: Colors.greenAccent,
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.opacity, size: 45),
                                  Text("Bio"),
                                  Text(bio[1])
                                ],
                              ),
                            ),
                          ),
                          Card(
                            color: Colors.greenAccent,
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.settings, size: 45),
                                  Text("M. Bio"),
                                  Text(mesinbio)
                                ],
                              ),
                            ),
                          ),   
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Card(
                            color: Colors.greenAccent,
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.invert_colors, size: 45),
                                  Text("M.Air"),
                                  Text(mesinair)
                                ],
                              ),
                            ),
                          ),
                          Card(
                            color: Colors.greenAccent,
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.settings, size: 45),
                                  Text("O. AIr"),
                                  Text(otomatisair)
                                ],
                              ),
                            ),
                          ),
                          Card(
                            color: Colors.greenAccent,
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.settings, size: 45),
                                  Text("O. Bio"),
                                  Text(otomatisBio)
                                ],
                              ),
                            ),
                          ),   
                        ],
                      )
                      // Text(snapshot.data.lahan),
                    ]
                  ),
                ),
              );
            }else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return Container();
          },
        ),
      ),
    );
  }
}
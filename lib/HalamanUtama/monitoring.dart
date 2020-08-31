import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:dhf_2020/HalamanUtama/sensor.dart';
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
      body: Center(
        child: FutureBuilder<SensorAlat>(
          future: futureSensor,
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(snapshot.data.lahan),
                  ]
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
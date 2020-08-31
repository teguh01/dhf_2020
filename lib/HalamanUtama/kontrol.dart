import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<DataSensor> kirimDataSensor() async {
  final http.Response response = await http.post(
    'https://platform.antares.id:8443/~/antares-cse/antares-id/smartPestisida/esp32_dhf_2020',
    headers: <String, String>{
      "X-M2M-Origin": "3d65eb3a72a7d964:6af31b96efd74987",
      "Content-Type": "application/json;ty=4",
      "Accept": "application/json",
    },
    body: jsonEncode(<String, String>{
      'm2m:cin': "con""{\"hari\":\"Sunday\",\"jam\":\"03\",\"temperature\":77,\"humidity\":40,\"wind_speed\":58,\"rain_drop\":\"hujan\",\"waterflow_bio\":65,\"waterflow_air\":70,\"mesin_bio\":\"Hidup\",\"mesin_air\":\"Hidup\",\"otomatis_bio\":\"Mati\",\"otomatis_air\":\"Mati\"}",
    }),
  );

  if (response.statusCode == 201) {
    return DataSensor.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to create album.');
  }
}

class DataSensor {
  final String title;

  DataSensor({this.title});

  factory DataSensor.fromJson(Map<String, dynamic> json) {
    return DataSensor(
      title: json['m2m:cin'],
    );
  }
}

class Kontrol extends StatefulWidget {
  @override
  _KontrolState createState() => _KontrolState();
}

class _KontrolState extends State<Kontrol> {

  Future<DataSensor> _futureDataSensor;

  void cek()async{
    setState(() async{
      _futureDataSensor = kirimDataSensor();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: RaisedButton(
          onPressed: ()async{
            cek();
          }
        ),
      ),
    );
  }
}

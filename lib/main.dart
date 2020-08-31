import 'package:flutter/material.dart';
import 'package:dhf_2020/Login/auth_services.dart';
import 'package:provider/provider.dart';

import 'package:dhf_2020/Login/wrapper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthServices.firebaseUserStream,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.greenAccent, primarySwatch: Colors.blue),
          darkTheme: ThemeData.dark(),
        home: Wrapper(),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:dhf_2020/Login/auth_services.dart';
import 'monitoring.dart' as monitoring;
import 'kontrol.dart' as kontrol;


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
    TabController controller;

  @override
  void initState(){
    controller = new TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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

      body: new TabBarView(
        controller: controller,
        children: <Widget>[
          new monitoring.Monitoring(),
          new kontrol.Kontrol(),
        ],
      ),

      bottomNavigationBar: new Material(
        color: Colors.green,
        child: new TabBar(
          controller: controller,
          tabs: <Widget>[
            new Tab(icon: new Icon(Icons.desktop_windows),text: "Monitoring",),
            new Tab(icon: new Icon(Icons.book), text: "Kontrol",),
          ],
        ),
      ),
    );
  }
}

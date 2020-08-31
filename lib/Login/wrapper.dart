import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:tambak_sehat/Login/main_page.dart';
import 'package:provider/provider.dart';

import 'login_page.dart';
//import 'main_page.dart';
import 'package:dhf_2020/HalamanUtama/halaman_utama.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseUser firebaseUser = Provider.of<FirebaseUser>(context);
    return (firebaseUser == null) ? LoginPage() : MyApp();
  }
}
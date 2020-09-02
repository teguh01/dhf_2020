import 'package:flutter/material.dart';
import 'auth_services.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _key = new GlobalKey<FormState>();

  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
    }
  }

  TextEditingController emailController = TextEditingController(text: "");
  final TextEditingController passwordController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return login();
  }

  Widget login(){
    return Scaffold(
      body: Form(
        key: _key,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            Container(width: 300, height: 150,),
            Center(
              child: Text("Smart Pestisida", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
            ),
            SizedBox(height: 50),
            Container(
              width: 300,
              height: 80,
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                ),
                validator: (e) {
                  if (e.isEmpty) {
                    return "Please insert email";
                  }
                  return null;
                },
              ),
            ),
            Container(
              width: 300,
              height: 80,
              child: TextFormField(
                obscureText: _secureText,
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: "Password",
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                  suffixIcon: IconButton(
                    onPressed: showHide,
                    icon: Icon(
                      _secureText ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                ),
                validator: (e) {
                  if (e.isEmpty) {
                    return "Please insert password";
                  }
                  return null;
                },
              ),
            ),
            RaisedButton(
              padding: EdgeInsets.all(17),
              color: Colors.green,
              child: Text(
                "Sign In",
                style: TextStyle(
                  color: Colors.black
                  )
                ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
                
              ),
              onPressed: () async {
                await AuthServices.signIn(
                    emailController.text, passwordController.text);
                check();
              },
            ),
            Container(width: 300, height: 60,),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Register()
                  ),
                );
              },
              child: Text(
                "Create New Account",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey)
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'auth_services.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
  final TextEditingController passwordController =
      TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Page"),
      ),
      body: Form(
        key: _key,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            Container(
              width: 300,
              height: 70,
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email"),
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
              height: 100,
              child: TextFormField(
                obscureText: _secureText,
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: "Password",
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
              child: Text("Sign Up"),
              onPressed: () async {
                await AuthServices.signUp(
                    emailController.text, passwordController.text);
                check();
              },
            ),
          ],
        ),
      ),
    );
  }
}
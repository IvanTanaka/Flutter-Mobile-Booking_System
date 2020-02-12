import 'package:flutter/material.dart';

import '../../router.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Colors.amber,
            Colors.white70,
          ],
        ),
      ),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildEmailField(),
            Container(
              height: 10,
            ),
            _buildPasswordField(),
            Container(
              height: 50,
            ),
            _buildLoginButton(),
            Container(
              height: 10,
            ),
            _buildRegisterButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              width: 2,
              color: Colors.black87,
            )),
        child: TextField(
          cursorColor: Colors.black87,
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            labelText: "Email",
            prefixIcon: Icon(
              Icons.email,
              color: Colors.black87,
            ),
            focusedBorder: InputBorder.none,
            labelStyle: TextStyle(
              color: Colors.black87,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              width: 2,
              color: Colors.black87,
            )),
        child: TextField(
          cursorColor: Colors.black87,
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
          obscureText: true,
          decoration: InputDecoration(
            labelText: "Password",
            prefixIcon: Icon(
              Icons.lock,
              color: Colors.black87,
            ),
            focusedBorder: InputBorder.none,
            labelStyle: TextStyle(
              color: Colors.black87,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Container(
      margin: EdgeInsets.only(left: 40, right: 40),
      width: double.infinity,
      child: RaisedButton(
        child: Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            "Login",
            style: TextStyle(
              color: Colors.black87,
            ),
          ),
        ),
        onPressed: () {
          Navigator.pushReplacementNamed(context, RoutePaths.Main);
        },
        color: Colors.amber,
      ),
    );
  }

  Widget _buildRegisterButton() {
    return Container(
      margin: EdgeInsets.only(left: 40, right: 40),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(
            width: 2,
            color: Colors.black87,
          )),
      child: RaisedButton(
        highlightElevation: 0,
        focusElevation: 0,
        hoverElevation: 0,
        highlightColor: Colors.amber,
        focusColor: Colors.white,
        elevation: 0,
        color: Colors.white,
        child: Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            "Register",
            style: TextStyle(
              color: Colors.black87,
            ),
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(context, "");
        },
      ),
    );
  }
}

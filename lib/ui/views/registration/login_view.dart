import 'package:flutter/material.dart';
import 'package:member_apps/ui/shared_colors.dart';
import 'package:member_apps/ui/widgets/shared_button.dart';

import '../../../router.dart';

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
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildLogo(),
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

  Widget _buildLogo() {
    return Text(
      "membee",
      style: Theme.of(context).textTheme.headline.merge(
            TextStyle(
              color: SharedColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
    );
  }

  Widget _buildEmailField() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: TextField(
          cursorColor: SharedColors.primaryColor,
          decoration: InputDecoration(
            labelText: "Email",
            prefixIcon: Icon(
              Icons.email,
//              color:  SharedColors.primaryColor,
            ),
            labelStyle: TextStyle(
//              color:  SharedColors.primaryColor,
                ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: TextField(
          obscureText: true,
          cursorColor: SharedColors.primaryColor,
          decoration: InputDecoration(
            labelText: "Password",
            prefixIcon: Icon(
              Icons.lock,
//              color:  SharedColors.primaryColor,
            ),
            labelStyle: TextStyle(
//              color:  SharedColors.primaryColor,
                ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: SharedButton(
          text: "Login",
          onTap: () {},
        ));
//    return Container(
//      margin: EdgeInsets.only(left: 40, right: 40),
//      width: double.infinity,
//      child: RaisedButton(
//        child: Container(
//          height: 50,
//          alignment: Alignment.center,
//          child: Text(
//            "Login",
//            style: TextStyle(
//              color: Colors.black87,
//            ),
//          ),
//        ),
//        onPressed: () {
//          Navigator.pushReplacementNamed(context, RoutePaths.Main);
//        },
//        color: Colors.amber,
//      ),
//    );
  }

  Widget _buildRegisterButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RoutePaths.Register);
        },
      child: Container(
        child: Text(
          "Don't have account yet? Click to register",
        ),
      ),
    );
  }
}

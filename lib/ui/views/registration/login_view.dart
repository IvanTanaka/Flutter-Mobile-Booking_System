import 'package:flutter/material.dart';
import 'package:member_apps/base_widget.dart';
import 'package:member_apps/core/viewmodels/views/registration/login_view_model.dart';
import 'package:member_apps/service_locator.dart';
import 'package:member_apps/ui/shared_colors.dart';
import 'package:member_apps/ui/widgets/shared_button.dart';

import '../../../router.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseWidget<LoginViewModel>(
        model: locator<LoginViewModel>(),
        onModelReady: (LoginViewModel viewModel) async {
          bool isLogin = await viewModel.isLogin;
          if(isLogin){
            Navigator.of(context).popUntil((route)=>route.isFirst);
            Navigator.pushReplacementNamed(context, RoutePaths.Main);
          }
        },
        builder:
            (BuildContext context, LoginViewModel viewModel, Widget child) {
          return _buildBody(viewModel);
        },
      ),);
  }

  Widget _buildBody(LoginViewModel viewModel) {
    return Container(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 50,
              ),
              _buildLogo(),
              _buildErrorMessage(viewModel),
              _buildEmailField(viewModel),
              Container(
                height: 10,
              ),
              _buildPasswordField(viewModel),
              Container(
                height: 50,
              ),
              _buildLoginButton(viewModel),
              Container(
                height: 10,
              ),
              _buildRegisterButton(),
              Container(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Text(
      "membee",
      style: Theme
          .of(context)
          .textTheme
          .headline
          .merge(
        TextStyle(
          color: SharedColors.primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildErrorMessage(LoginViewModel viewModel) {
    return StreamBuilder<String>(
      stream: viewModel.errorMessageStream,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.symmetric(vertical: 5),
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.transparent),
              borderRadius: BorderRadius.circular(10),
              color: SharedColors.errorColor,
            ),
            child: Text(snapshot.data, style: TextStyle(
              color: SharedColors.txtAccentColor,
            ),),
          );
        }
        return Container();
      },
    );
  }

  Widget _buildEmailField(LoginViewModel viewModel) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: TextFormField(
          validator: (String value){
            return viewModel.validateEmail(value);
          },
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

  Widget _buildPasswordField(LoginViewModel viewModel) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: TextFormField(
          validator: (String value){
            return viewModel.validatePassword(value);
          },
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

  Widget _buildLoginButton(LoginViewModel viewModel) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: SharedButton(
        text: "Login",
        onTap: () async {
          if (_formKey.currentState.validate()){
            await viewModel.loginUser();
            bool isLogin = await viewModel.isLogin;
            if(isLogin){
              Navigator.of(context).popUntil((route)=>route.isFirst);
              Navigator.pushReplacementNamed(context, RoutePaths.Main);
            }
          }
        },
      ),);
  }

  Widget _buildRegisterButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RoutePaths.Register);
      },
      child: Container(
        child: RichText(
          text: TextSpan(
            text: "Don't have account yet?",
            style: TextStyle(color: SharedColors.txtColor),
            children: <TextSpan>[
              TextSpan(text: ' Click to register', style: TextStyle(color: SharedColors.linkColor)),
            ],
          ),
        ),
      ),
    );
  }
}

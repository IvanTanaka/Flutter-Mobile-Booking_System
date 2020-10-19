import 'package:flutter/material.dart';
import 'package:member_apps/base_widget.dart';
import 'package:member_apps/core/viewmodels/views/registration/login_view_model.dart';
import 'package:member_apps/service_locator.dart';
import 'package:member_apps/ui/shared_colors.dart';
import 'package:member_apps/ui/widgets/shared_button.dart';
import 'package:member_apps/ui/widgets/shared_text_form_field.dart';

import '../../../router.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _backgroundLayout = "assets/images/backgroundlogin-01.png";
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseWidget<LoginViewModel>(
        model: locator<LoginViewModel>(),
        onModelReady: (LoginViewModel viewModel) async {
          bool isLogin = await viewModel.isLogin;
          if (isLogin) {
            Navigator.of(context).popUntil((route) => route.isFirst);
            Navigator.pushReplacementNamed(context, RoutePaths.Main);
          }
        },
        builder:
            (BuildContext context, LoginViewModel viewModel, Widget child) {
          return _buildBody(viewModel);
        },
      ),
    );
  }

  Widget _buildBody(LoginViewModel viewModel) {
    return Stack(
      children: <Widget>[
        Container(
          child: new Image.asset(
            _backgroundLayout,
            fit: BoxFit.fill,
          ),
          height: double.infinity,
          width: double.infinity,
        ),
        Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildErrorMessage(viewModel),
                  Container(
                    child: _buildLogo(),
                  ),
                  Container(
                    child: _buildEmailField(viewModel),
                    margin: EdgeInsets.only(top: 80),
                  ),
                  _buildPasswordField(viewModel),
                  Container(
                    child: _buildForgetPassword(),
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(bottom: 50, right: 20, top: 20),
                  ),
                  Container(
                    child: _buildLoginButton(viewModel),
                    margin: EdgeInsets.only(bottom: 50),
                  ),
                  Container(
                    child: _buildDividerLabel(),
                    margin: EdgeInsets.only(bottom: 50),
                  ),
                  Container(
                    child: _buildGoogleSignInButton(viewModel),
                  ),
                  Container(
                    child: _buildRegisterButton(),
                    margin: EdgeInsets.only(top: 90),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLogo() {
    return Text(
      "Welcome back",
      style: Theme.of(context).textTheme.headline.merge(
            TextStyle(
                color: SharedColors.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 30),
          ),
    );
  }

  Widget _buildDividerLabel() {
    return Container(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new Container(
            width: 60,
            child: Divider(
              color: Colors.black,
              height: 0.5,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Text("or"),
          ),
          Container(
            width: 60,
            child: Divider(
              color: Colors.black,
              height: 0.5,
            ),
          ),
        ],
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
            child: Text(
              snapshot.data,
              style: TextStyle(
                color: SharedColors.txtAccentColor,
              ),
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget _buildEmailField(LoginViewModel viewModel) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
      child: Container(
        child: SharedTextFormField(
          controller: emailController,
          validator: (String value) => viewModel.validateEmail(value),
          hintText: "Email",
        ),
      ),
    );
  }

  Widget _buildPasswordField(LoginViewModel viewModel) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: SharedTextFormField(
          controller: passwordController,
          validator: (String value) => viewModel.validatePassword(value),
          obscureText: true,
          hintText: "Password",
        ),
      ),
    );
  }

  Widget _buildLoginButton(LoginViewModel viewModel) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: SharedButton(
        text: "LOG IN",
        onTap: () async {
          if (_formKey.currentState.validate()) {
            await viewModel.loginUser();
            bool isLogin = await viewModel.isLogin;
            if (isLogin) {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.pushReplacementNamed(context, RoutePaths.Main);
            }
          }
        },
      ),
    );
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
              TextSpan(
                  text: ' Register',
                  style: TextStyle(
                      color: SharedColors.primaryColor,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForgetPassword() {
    return GestureDetector(
      onTap: () => {},
      child: Container(
        child: RichText(
          text: TextSpan(
            text: "Forgot Password?",
            style: TextStyle(
                color: SharedColors.primaryColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildGoogleSignInButton(LoginViewModel viewModel) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: SharedButton(
//          isLoading: viewModel.busy,
          isGoogle: true,
          activeColor: SharedColors.whiteColor,
          textColor: SharedColors.blackColor,
          preWidget: Row(
            children: [
              Image.asset(
                "assets/images/google_icon.png",
                height: 20,
                width: 20,
              ),
              Container(
                width: 10,
              )
            ],
          ),
          text: "Log in with Google",
          txtFontSize: 15,
          onTap: () async {
            if (_formKey.currentState.validate()) {
              await viewModel.loginUser();
              bool isLogin = await viewModel.isLogin;
              if (isLogin) {
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.pushReplacementNamed(context, RoutePaths.Main);
              }
            }
          },
        ));
  }
}

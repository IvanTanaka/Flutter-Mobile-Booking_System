import 'package:flutter/material.dart';
import 'package:member_apps/base_widget.dart';
import 'package:member_apps/core/viewmodels/views/registration/register_view_model.dart';
import 'package:member_apps/service_locator.dart';
import 'package:member_apps/ui/shared_colors.dart';
import 'package:member_apps/ui/widgets/shared_button.dart';
import 'package:member_apps/ui/widgets/shared_text_form_field.dart';

import '../../../router.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseWidget<RegisterViewModel>(
        model: locator<RegisterViewModel>(),
        builder:
            (BuildContext context, RegisterViewModel viewModel, Widget child) {
          return _buildBody(viewModel);
        },
      ),
    );
  }

  Widget _buildBody(RegisterViewModel viewModel) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          child: Image.asset("assets/images/background_registration.png"),
        ),
        Container(
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
                  _buildSubhead(),
                  _buildErrorMessage(viewModel),
                  Container(
                    height: 25,
                  ),
                  _buildEmailField(viewModel),
                  Container(
                    height: 20,
                  ),
                  _buildNameField(viewModel),
                  Container(
                    height: 20,
                  ),
                  _buildPhoneNumberField(viewModel),
                  Container(
                    height: 20,
                  ),
                  _buildPasswordField(viewModel),
                  Container(
                    height: 20,
                  ),
                  _buildConfirmPasswordField(viewModel),
                  Container(
                    height: 40,
                  ),
                  _buildSubmitButton(viewModel),
                  Container(
                    height: 16,
                  ),
                  _buildDividerLabel(),
                  Container(
                    height: 16,
                  ),
                  _buildGoogleSignInButton(viewModel),
                  Container(
                    height: 35,
                  ),
                  _buildLoginLink(),
                  Container(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubhead() {
    return Text(
      "Create Account",
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w700,
        color: SharedColors.primaryOrangeColor,
      ),
    );
  }

  Widget _buildErrorMessage(RegisterViewModel viewModel) {
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

  Widget _buildNameField(RegisterViewModel viewModel) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: SharedTextFormField(
          validator: (String value) {
            return viewModel.validateName(value);
          },
          hintText: "Name",
        ),
      ),
    );
  }

  Widget _buildPhoneNumberField(RegisterViewModel viewModel) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: SharedTextFormField(
          validator: (String value) {
            return viewModel.validatePhoneNumber(value);
          },
          hintText: "Phone Number",
        ),
      ),
    );
  }

  Widget _buildEmailField(RegisterViewModel viewModel) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: SharedTextFormField(
          validator: (String value) {
            return viewModel.validateEmail(value);
          },
          hintText: "Email",
        ),
      ),
    );
  }

  Widget _buildPasswordField(RegisterViewModel viewModel) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: SharedTextFormField(
          validator: (String value) {
            return viewModel.validatePassword(value);
          },
          obscureText: true,
          hintText: "Password",
        ),
      ),
    );
  }

  Widget _buildConfirmPasswordField(RegisterViewModel viewModel) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: SharedTextFormField(
          validator: (String value) {
            return viewModel.validateConfirmPassword(value);
          },
          onChanged: (String value) {
            viewModel.confirmPassword = value;
          },
          obscureText: true,
          hintText: "Confirm Password",
        ),
      ),
    );
  }

  Widget _buildSubmitButton(RegisterViewModel viewModel) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: SharedButton(
//          isLoading: viewModel.busy,
          text: "Submit",
          onTap: () async {
            if (_formKey.currentState.validate()) {
              await viewModel.registerUser();
              bool isLogin = await viewModel.isLogin;
              if (isLogin) {
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.pushReplacementNamed(context, RoutePaths.Main);
              }
            }
          },
        ));
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

  Widget _buildGoogleSignInButton(RegisterViewModel viewModel) {
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
          text: "Sign up with Google",
          onTap: () async {
            if (_formKey.currentState.validate()) {
              await viewModel.registerUser();
              bool isLogin = await viewModel.isLogin;
              if (isLogin) {
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.pushReplacementNamed(context, RoutePaths.Main);
              }
            }
          },
        ));
  }

  Widget _buildLoginLink() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RoutePaths.Login);
      },
      child: Container(
        child: RichText(
          text: TextSpan(
            text: "Already have an account? ",
            style: TextStyle(
                color: SharedColors.blackColor,
                fontWeight: FontWeight.w400,
                fontSize: 13),
            children: <TextSpan>[
              TextSpan(
                text: 'Log in',
                style: TextStyle(
                  color: SharedColors.primaryOrangeColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

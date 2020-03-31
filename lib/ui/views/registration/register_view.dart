import 'package:flutter/material.dart';
import 'package:member_apps/base_widget.dart';
import 'package:member_apps/core/viewmodels/views/registration/register_view_model.dart';
import 'package:member_apps/service_locator.dart';
import 'package:member_apps/ui/shared_colors.dart';
import 'package:member_apps/ui/widgets/shared_button.dart';

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
              _buildSubhead(),
              _buildNameField(viewModel),
              Container(
                height: 10,
              ),
              _buildPhoneNumberField(viewModel),
              Container(
                height: 10,
              ),
              _buildEmailField(viewModel),
              Container(
                height: 10,
              ),
              _buildPasswordField(viewModel),
              Container(
                height: 10,
              ),
              _buildConfirmPasswordField(viewModel),
              Container(
                height: 50,
              ),
              _buildSubmitButton(viewModel),
              Container(
                height: 10,
              ),
              _buildRLoginButton(),
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
      style: Theme.of(context).textTheme.headline.merge(
            TextStyle(
              color: SharedColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
    );
  }

  Widget _buildSubhead() {
    return Text(
      "Sign Up",
      style: Theme.of(context).textTheme.subhead,
    );
  }

  Widget _buildNameField(RegisterViewModel viewModel) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: TextFormField(
          validator: (String value){
            return viewModel.validateName(value);
          },
          cursorColor: SharedColors.primaryColor,
          decoration: InputDecoration(
            labelText: "Name",
            prefixIcon: Icon(
              Icons.person,
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

  Widget _buildPhoneNumberField(RegisterViewModel viewModel) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: TextFormField(
          validator: (String value){
            return viewModel.validatePhoneNumber(value);
          },
          cursorColor: SharedColors.primaryColor,
          decoration: InputDecoration(
            labelText: "Phone Number",
            prefixIcon: Icon(
              Icons.smartphone,
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

  Widget _buildEmailField(RegisterViewModel viewModel) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: TextFormField(
          validator: (String value){
            return viewModel.validateEmail(value);
          },
          cursorColor: SharedColors.primaryColor,
          keyboardType: TextInputType.emailAddress,
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

  Widget _buildPasswordField(RegisterViewModel viewModel) {
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


  Widget _buildConfirmPasswordField(RegisterViewModel viewModel) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: TextFormField(
          onChanged: (String value){
            viewModel.confirmPassword = value;
          },
          obscureText: true,
          cursorColor: SharedColors.primaryColor,
          decoration: InputDecoration(
            labelText: "Confirm Password",
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

  Widget _buildSubmitButton(RegisterViewModel viewModel) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: SharedButton(
          isLoading: viewModel.busy,
          text: "Submit",
          onTap: () async {
            if(_formKey.currentState.validate()){
              bool register = await viewModel.registerUser();
              if(register){
                Navigator.pushNamed(context, RoutePaths.Login);
              }
            }
          },
        ));
  }

  Widget _buildRLoginButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RoutePaths.Login);
      },
      child: Container(
        child: Text(
          "Sign in",
        ),
      ),
    );
  }
}

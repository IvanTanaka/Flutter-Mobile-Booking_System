import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:member_apps/base_widget.dart';
import 'package:member_apps/core/viewmodels/views/profile_view_model.dart';
import 'package:member_apps/router.dart';
import 'package:member_apps/service_locator.dart';
import 'package:member_apps/ui/shared_colors.dart';
import 'package:member_apps/ui/widgets/shared_text_form_field.dart';

class ProfileEditView extends StatefulWidget {
  @override
  _ProfileEditViewState createState() => _ProfileEditViewState();
}

class _ProfileEditViewState extends State<ProfileEditView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 3,
        toolbarHeight: 60,
        backgroundColor: SharedColors.whiteColor,
        title: Container(
          height: 60,
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Edit Your Account",
                style: TextStyle(color: SharedColors.primaryBlue, fontSize: 24, fontWeight: FontWeight.w700),
              )
            ],
          ),
        ),
      ),
      body: _buildBody(),
      floatingActionButton: Container(
        width: 370,
        height: 50,
        child: FloatingActionButton.extended(
          onPressed: () {
          },
          label: Text(
            'Save Changes',
            style: TextStyle(
              color: SharedColors.whiteColor,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          backgroundColor: SharedColors.primaryBlue,
        ),
      ),
    );
  }
}

class _buildBody extends StatelessWidget {
  const _buildBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
        ),
        Container(
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 30,
                  ),
                  _buildNameField(),
                  Container(
                    height: 30,
                  ),
                  _buildEmailField(),
                  Container(
                    height: 30,
                  ),
                  _buildPhoneField(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _buildPhoneField extends StatelessWidget {
  const _buildPhoneField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: SharedTextFormField(
          validator: (String value) {},
          hintText: "Phone Number",
        ),
      ),
    );
  }
}

class _buildEmailField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: SharedTextFormField(
          validator: (String value) {},
          hintText: "Email",
        ),
      ),
    );
  }
}

class _buildNameField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: SharedTextFormField(
          validator: (String value) {},
          hintText: "Name",
        ),
      ),
    );
  }
}

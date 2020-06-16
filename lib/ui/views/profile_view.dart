import 'package:flutter/material.dart';
import 'package:member_apps/base_widget.dart';
import 'package:member_apps/core/viewmodels/views/profile_view_model.dart';
import 'package:member_apps/router.dart';
import 'package:member_apps/service_locator.dart';
import 'package:member_apps/ui/shared_colors.dart';
import 'package:member_apps/ui/widgets/shared_button.dart';
import 'package:member_apps/ui/widgets/wallet/wallet_container.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: SharedColors.scaffoldColor,
        title: Text("Profile"),
      ),
      body: BaseWidget<ProfileViewModel>(
        model: locator<ProfileViewModel>(),
        onModelReady: (ProfileViewModel viewModel) async {
          await viewModel.loadUser();
        },
        builder:
            (BuildContext context, ProfileViewModel viewModel, Widget child) {
          return _buildBody(viewModel);
        },
      ),
    );
  }

  Widget _buildBody(ProfileViewModel viewModel) {
    return Container(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            (viewModel.userModel != null)
                ? Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(radius: 30,backgroundImage: AssetImage("assets/images/avatar-blank.png"),),
                        Container(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _buildName(viewModel),
                            _buildEmail(viewModel),
                            _buildPhoneNumber(viewModel),
                          ],
                        ),
                      ],
                    ),
                  )
                : Container(),
            Divider(thickness: 1,),
            WalletContainer(),
            Container(height: 250,),
            Container(
              height: 10,
            ),
            _buildLogout(viewModel),
          ],
        ),
      ),
    );
  }

  Widget _buildName(ProfileViewModel viewModel) {
    return Row(
      children: <Widget>[
        Icon(
          Icons.person,
          color: SharedColors.primaryColor,
          size: 20,
        ),
        Container(
          width: 10,
        ),
        Container(
          child: Text(
            viewModel.userModel.name,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }

  Widget _buildEmail(ProfileViewModel viewModel) {
    return Row(
      children: <Widget>[
        Icon(
          Icons.email,
          color: SharedColors.primaryColor,
          size: 20,
        ),
        Container(
          width: 10,
        ),
        Container(
          child: Text(
            viewModel.userModel.email,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneNumber(ProfileViewModel viewModel) {
    return Row(
      children: <Widget>[
        Icon(
          Icons.phone_android,
          color: SharedColors.primaryColor,
          size: 20,
        ),
        Container(
          width: 10,
        ),
        Container(
          child: Text(
            viewModel.userModel.phoneNumber,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildLogout(ProfileViewModel viewModel) {
    return Container(
      child: SharedButton(
        text: "Logout",
        onTap: () async {
          await viewModel.logout();
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.pushNamed(context, RoutePaths.Login);
        },
      ),
    );
    return GestureDetector(
      onTap: () async {
        await viewModel.logout();
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.pushNamed(context, RoutePaths.Login);
      },
      child: Container(
        child: Text("Logout"),
      ),
    );
  }
}

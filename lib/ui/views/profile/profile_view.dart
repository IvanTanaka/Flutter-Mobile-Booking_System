import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:member_apps/base_widget.dart';
import 'package:member_apps/core/viewmodels/views/profile_view_model.dart';
import 'package:member_apps/router.dart';
import 'package:member_apps/service_locator.dart';
import 'package:member_apps/ui/shared_colors.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BaseWidget<ProfileViewModel>(
          model: locator<ProfileViewModel>(),
          onModelReady: (ProfileViewModel viewModel) async {
            await viewModel.loadUser();
          },
          builder:
              (BuildContext context, ProfileViewModel viewModel, Widget child) {
            return _buildBody(viewModel);
          },
        ),
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
                ? GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RoutePaths.ProfileEdit);
                  },
                  child: Card(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 15,
                              ),
                              _buildName(viewModel),
                              Container(
                                height: 5,
                              ),
                              _buildEmail(viewModel),
                              Container(
                                height: 5,
                              ),
                              _buildPhoneNumber(viewModel),
                              Container(
                                height: 15,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                )
                : Container(),

            Container(
              height: 25,
            ),

            GestureDetector(
              child: _buildHelp(),
            ),

            Divider(
              height: 20,
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),

            GestureDetector(
              onTap: () async {
                await viewModel.logout();
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.pushNamed(context, RoutePaths.Login);
              },
              child: _buildSignOut(),
            ),

            Divider(
              height: 20,
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),

            // IgnorePointer(
            //   child: WalletContainer(),
            // ),

          ],
        ),
      ),
    );
  }

  Widget _buildName(ProfileViewModel viewModel) {
    return Row(
      children: <Widget>[
        Container(
          width: 10,
        ),
        Container(
          child: Text(
            'Hello, ',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: SharedColors.primaryBlue),
          ),
        ),
        Container(
          child: Text(
            viewModel.userModel.name,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: SharedColors.primaryBlue),
          ),
        ),
      ],
    );
  }

  Widget _buildEmail(ProfileViewModel viewModel) {
    return Row(
      children: <Widget>[
        Container(
          width: 10,
        ),
        Container(
          child: Text(
            viewModel.userModel.email,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneNumber(ProfileViewModel viewModel) {
    return Row(
      children: <Widget>[
        Container(
          width: 10,
        ),
        Container(
          child: Text(
            viewModel.userModel.phoneNumber,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
        ),
        Container(
          width: 220,
        ),
        Icon(
          Icons.edit,
          size: 20,
        )
      ],
    );
  }

}

class _buildSignOut extends StatelessWidget {
  const _buildSignOut({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(10,0,10,0),
      elevation: 0,
      child: Row(
        children: <Widget>[
          Container(
            width: 10,
          ),
          Icon(
            Icons.exit_to_app,
            size: 25,
          ),
          Container(
            width: 20,
          ),
          Text(
            'Sign Out',
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500
            ),
          ),
          Container(
            width: 223,
          ),
          Icon(Icons.arrow_right, size: 40,),

        ],
      ),
    );
  }
}

class _buildHelp extends StatelessWidget {
  const _buildHelp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(10,0,10,0),
      elevation: 0,
      child: Row(
        children: <Widget>[
          Container(
            width: 10,
          ),
          Icon(
            Icons.help,
            size: 25,
          ),
          Container(
            width: 20,
          ),
          Text(
            'Help',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500
            ),
          ),
          Container(
            width: 250,
          ),
          Icon(Icons.arrow_right, size: 40,)
        ],
      ),
    );
  }
}

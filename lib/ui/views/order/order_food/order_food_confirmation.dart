import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:member_apps/ui/prototype_constant.dart';
import 'package:member_apps/ui/widgets/shared_button.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class OrderFoodConfirmation extends StatefulWidget {
  @override
  _OrderFoodConfirmationState createState() => _OrderFoodConfirmationState();
}

class _OrderFoodConfirmationState extends State<OrderFoodConfirmation> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Widget _buildStoreTop() {
    return Container(
      child: Center(
        child: Row(
          children: <Widget>[
            _buildFranchisePicture(),
            Container(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildFranchiseName(),
                  _buildStoreName(),
                  _buildStorePhone(),
                  _buildStoreAddress(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFranchisePicture() {
    return Container(
      padding: EdgeInsets.all(10),
      child: CircleAvatar(
        radius: 50,
        backgroundImage:
        NetworkImage(PrototypeConstant.FRANCHISE_PROFILE_IMAGE),
      ),
    );
  }

  Widget _buildFranchiseName() {
    return Container(
      child: Text(
        "Golden Lamian",
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  Widget _buildStoreName() {
    return Container(
      child: Text(
        "Cab. Cemara",
        style: Theme.of(context).textTheme.subhead,
      ),
    );
  }

  Widget _buildStoreAddress() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 20,
            child: Icon(
              FontAwesomeIcons.mapMarker,
              size: 15,
            ),
          ),
          Container(
            width: 5,
          ),
          Expanded(
            child: Text(
              PrototypeConstant.LOREM_IPSUM,
              overflow: TextOverflow.visible,
              softWrap: true,
              maxLines: 5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStorePhone() {
    return Row(
      children: <Widget>[
        Icon(
          FontAwesomeIcons.phone,
          size: 15,
        ),
        Container(
          width: 10,
        ),
        Container(
          child: Text("+6282272675309"),
        ),
      ],
    );
  }



  Widget _buildContactUsButton() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            child: SharedButton(
              text: "Contact Us",
              onTap: () async {
                await onTapContactUs("+6282272675309");
              },
            ),
          ),
        ),
      ],
    );
  }


  Future onTapContactUs(String phoneNumber) async {
    if (await UrlLauncher.canLaunch('whatsapp://send?phone=$phoneNumber')) {
      await UrlLauncher.launch('whatsapp://send?phone=$phoneNumber');
    } else {
      UrlLauncher.launch('tel:$phoneNumber');
    }
  }

}

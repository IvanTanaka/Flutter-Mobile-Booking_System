import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:member_apps/ui/prototype_constant.dart';
import 'package:member_apps/ui/shared_colors.dart';
import 'package:member_apps/ui/widgets/shared_button.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class OrderStore extends StatefulWidget {
  @override
  _OrderStoreState createState() => _OrderStoreState();
}

class _OrderStoreState extends State<OrderStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: SharedColors.scaffoldColor,
        centerTitle: true,
        title: Stack(
          children: <Widget>[
            Container(
              height: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Balance",
                    style: Theme.of(context).textTheme.caption.merge(
                          TextStyle(
                            color: SharedColors.primaryColor,
                          ),
                        ),
                  ),
                  Text(
                    "Rp 12.000",
                    style: Theme.of(context).textTheme.title,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      child: Column(
        children: <Widget>[
          _buildStoreTop(),
          _buildContactUsButton(),
          Divider(),
          Expanded(child: SingleChildScrollView(child: _buildStoreProduct())),
        ],
      ),
    );
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

  Widget _buildStoreProduct() {
    return Column(
      children: <Widget>[

        Container(
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return _buildStoreProductItem();
              }),
        ),
      ],
    );
  }

  Widget _buildStoreProductItem() {
    return Column(
      children: <Widget>[
        Container(
          height: 120,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Image.network(
                  PrototypeConstant.FRANCHISE_PROFILE_IMAGE,
                  height: 20,
                  width: 20,
                ),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 4,
                          child: Container(
                            child: Text(
                              "Product A Product A Product A Product A",
                              style: Theme.of(context).textTheme.body1.merge(TextStyle(fontSize: 20)),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(right: 10),
                                alignment: Alignment.centerRight,
                                child: Text("1.000.000.000", style: Theme.of(context).textTheme.body2.merge(TextStyle(fontSize: 20)),),
                              ),
                              Container(
                                padding: EdgeInsets.only(right: 10),
                                alignment: Alignment.centerRight,
                                child: Text("9.999.999.999", style: Theme.of(context).textTheme.body1.merge(TextStyle(fontWeight: FontWeight.w300, decoration: TextDecoration.lineThrough)),),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 40),
                      child: ExtendedText(
                        "ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ ABCDEFGHIJKLMNOPQRSTUVWXYZ ABCDEFGHIJKLMNOPQRSTUVWXYZ ABCDEFGHIJKLMNOPQRSTUVWXYZ",
                        style: Theme.of(context).textTheme.caption,
                        maxLines: 3,
                        overFlowTextSpan: OverFlowTextSpan(
                          text: " ...",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider()
      ],
    );
  }
}

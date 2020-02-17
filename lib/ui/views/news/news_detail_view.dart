import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:member_apps/router.dart';
import 'package:member_apps/ui/prototype_constant.dart';
import 'package:member_apps/ui/shared_colors.dart';
import 'package:member_apps/ui/widgets/shared_button.dart';

class NewsDetailView extends StatefulWidget {
  @override
  _NewsDetailViewState createState() => _NewsDetailViewState();
}

class _NewsDetailViewState extends State<NewsDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: _buildNewsDetailTop(),
          ),
          Expanded(child: _buildNewsDetailBody()),
        ],
      ),
    );
  }

  Widget _buildNewsDetailTop() {
    return Stack(
      children: <Widget>[
        new ClipRect(
          child: new FittedBox(
            fit: BoxFit.cover,
            alignment: Alignment.center,
            child: new Container(
              height: MediaQuery.of(context).size.width/2,
              child:
              Image.network(
                PrototypeConstant.NEWS_IMAGE_URL,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  print("Add to Favorite");
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Icon(
                    FontAwesomeIcons.heart,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildNewsDetailBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 5,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "franchise_name",
              style: Theme.of(context)
                  .textTheme
                  .title
                  .merge(TextStyle(color: SharedColors.txtColor)),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "date",
              style: Theme.of(context).textTheme.caption,
            ),
          ),
          Divider(
            color: Colors.grey[500],
          ),
          _buildNewsDetailDescription(),
          _buildNewsDetailTermsAndConditions(),
          _buildNewsDetailLocations(),
          Container(
            height: 20,
          )
        ],
      ),
    );
  }

  Widget _buildNewsDetailDescription() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 10,
          ),
          Text(
            "Description",
            style: Theme.of(context)
                .textTheme
                .subhead
                .merge(TextStyle(fontWeight: FontWeight.w600)),
          ),
          Container(
            height: 5,
          ),
          Text(
            "news_description ${PrototypeConstant.LOREM_IPSUM}",
            style: Theme.of(context).textTheme.body1,
          ),
          Container(
            height: 10,
          )
        ],
      ),
    );
  }

  Widget _buildNewsDetailTermsAndConditions() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 10,
          ),
          Text("Terms & Conditions",
              style: Theme.of(context)
                  .textTheme
                  .subhead
                  .merge(TextStyle(fontWeight: FontWeight.w600))),
          ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 5),
              physics: NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.solidCircle,
                        size: 7,
                      ),
                      Container(
                        width: 5,
                      ),
                      Text("TermsAndConditions[index]"),
                    ],
                  ),
                );
              }),
          Container(
            height: 10,
          )
        ],
      ),
    );
  }

  Widget _buildNewsDetailLocations() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context,RoutePaths.OrderStore);
              },
              child: Container(
                  margin: EdgeInsets.only(top: 5, bottom: 10),
                  child: Material(
                    elevation: 3,
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 10, bottom: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "Cab. index",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            height: 5,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.mapMarker,
                                size: 12,
                                color: SharedColors.primaryColor,
                              ),
                              Container(
                                width: 10,
                              ),
                              Container(
                                child: Text("Jl. Sparman bla bla bla"),
                              ),
                            ],
                          ),
                          Container(
                            height: 5,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.phone,
                                size: 12,
                                color: SharedColors.primaryColor,
                              ),
                              Container(
                                width: 10,
                              ),
                              Container(
                                child: Text("+6282272675309"),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )),
            );
          }),
    );
  }

  Widget _buildCheckMore(){
    return Container(
      color: SharedColors.scaffoldColor,
      child: SharedButton(
        text: "Check More",
        onTap: (){},
      ),
    );
  }
}

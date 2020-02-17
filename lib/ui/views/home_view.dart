import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:member_apps/ui/prototype_constant.dart';
import 'package:member_apps/ui/shared_colors.dart';
import 'package:member_apps/ui/views/news/widgets/news_container.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: SharedColors.scaffoldColor,
        title: Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "membee",
                style: TextStyle(color: SharedColors.primaryColor),
              )
            ],
          ),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildWalletContainer(),
            Container(
              height: 20,
            ),
            _buildListService(),
            Container(
              height: 50,
            ),
            _buildLatestNews()
          ],
        ),
      ),
    );
  }

  Widget _buildWalletContainer() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(5),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              height: 50,
              decoration: BoxDecoration(
                color: SharedColors.accentColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
              ),
              child: Container(
                child: Row(
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.wallet,
                      size: 20,
                      color: SharedColors.txtAccentColor,
                    ),
                    Container(
                      width: 10,
                    ),
                    Text(
                      "Balance",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: SharedColors.txtAccentColor),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "12.000",
                          style: TextStyle(
                              color: SharedColors.txtAccentColor,
                              fontSize: 22,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 4,
            ),
            Container(
              height: 8,
              decoration: BoxDecoration(
                color: SharedColors.accentColor,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(5)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildListService() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Text("Start Ordering", style: TextStyle(
              fontSize: 19,
              color: SharedColors.primaryColor
            ),),
          ),
          GridView.count(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true, crossAxisCount: 4,
            // Generate 100 widgets that display their index in the List.
            children: <Widget>[
              _buildServiceItem(itemName: "Food"),
              _buildServiceItem(itemName: "Barber"),
              _buildServiceItem(itemName: "Karaoke"),
              _buildServiceItem(itemName: "Sports"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceItem({String itemName}){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 30,
            backgroundImage:
            NetworkImage(PrototypeConstant.FRANCHISE_PROFILE_IMAGE),
          ),
          Text(
            itemName,
            style: Theme.of(context).textTheme.body2,
          ),
        ],
      ),
    );
  }

  Widget _buildLatestNews() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Latest News",
              style: Theme.of(context).textTheme.title.merge(TextStyle(color: SharedColors.accentColor)),
            ),
          ),
          Divider(),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (BuildContext context, int itemCount) {
              return NewsContainer(
                franchiseName: "Golden Lamian",
                franchiseProfileImage:
                    PrototypeConstant.FRANCHISE_PROFILE_IMAGE,
                newsImage: PrototypeConstant.NEWS_IMAGE_URL,
                newsDescription: PrototypeConstant.LOREM_IPSUM,
              );
            },
          ),
        ],
      ),
    );
  }
}

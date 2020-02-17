import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:member_apps/router.dart';
import 'package:member_apps/ui/prototype_constant.dart';
import 'package:member_apps/ui/shared_colors.dart';
import 'package:member_apps/ui/views/news/widgets/news_container.dart';

class NewsView extends StatefulWidget {
  @override
  _NewsViewState createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: SharedColors.scaffoldColor,
        title: Stack(
          children: <Widget>[
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "News",
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RoutePaths.NewsFavorite);
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                alignment: Alignment.centerRight,
                child: Icon(FontAwesomeIcons.heart),
              ),
            )
          ],
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (BuildContext context, int itemCount) {
          return NewsContainer(
            franchiseName: "Golden Lamian",
            franchiseProfileImage: PrototypeConstant.FRANCHISE_PROFILE_IMAGE,
            newsImage: PrototypeConstant.NEWS_IMAGE_URL,
            newsDescription: PrototypeConstant.LOREM_IPSUM,

          );
        },
      ),
    );
  }

}

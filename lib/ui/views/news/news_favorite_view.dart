import 'package:flutter/material.dart';
import 'package:member_apps/ui/prototype_constant.dart';
import 'package:member_apps/ui/shared_colors.dart';
import 'package:member_apps/ui/views/news/widgets/news_container.dart';

class NewsFavoriteView extends StatefulWidget {
  @override
  _NewsFavoriteViewState createState() => _NewsFavoriteViewState();
}

class _NewsFavoriteViewState extends State<NewsFavoriteView> {
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
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (BuildContext contextt, int itemCount) {
          return NewsContainer(
            franchiseName: "Dana",
            franchiseProfileImage: PrototypeConstant.FRANCHISE_PROFILE_IMAGE_2,
            newsImage: PrototypeConstant.NEWS_IMAGE_URL_2,
            newsDescription: PrototypeConstant.LOREM_IPSUM,
          );
        },
      ),
    );
  }
}

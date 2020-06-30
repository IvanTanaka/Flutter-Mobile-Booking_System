import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:member_apps/core/models/news_model.dart';
import 'package:member_apps/router.dart';

class NewsContainer extends StatefulWidget {
  final NewsModel newsModel;

  const NewsContainer({Key key, this.newsModel}) : super(key: key);

  @override
  _NewsContainerState createState() => _NewsContainerState();
}

class _NewsContainerState extends State<NewsContainer> {
  NewsModel get model => widget.newsModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, RoutePaths.NewsDetail, arguments: model.id);
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildNewsHeader(),
            _buildNewsBody(),
            _buildNewsDescription(),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsHeader() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: <Widget>[
          Container(
            child: CircleAvatar(
              backgroundImage:
              NetworkImage(model.franchise.imagePath),
              radius: MediaQuery.of(context).size.width * (3 / 80),
            ),
          ),
          Container(
            width: 10,
          ),
          Container(
            child: Text(
              model.franchise.name,
              style: Theme.of(context).textTheme.body2,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildNewsBody() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black12),
          top: BorderSide(color: Colors.black12),
        ),
      ),
      child: Image.network(
        model.imagePath,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
      ),
    );
  }

  Widget _buildNewsDescription() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  model.franchise.name,
                  style: Theme.of(context).textTheme.body2,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ExtendedText(
                  model.description,
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  overFlowTextSpan: OverFlowTextSpan(
                    text: " ... more",
                    style: TextStyle(color: Colors.black45),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 20,
          ),
        ],
      ),
    );
  }
}

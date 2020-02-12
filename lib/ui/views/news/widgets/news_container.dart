import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:member_apps/router.dart';
import 'package:member_apps/ui/prototype_constant.dart';

class NewsContainer extends StatefulWidget {
  final String franchiseName;
  final String franchiseProfileImage;
  final String newsImage;
  final String newsDescription;

  const NewsContainer({Key key, this.franchiseName, this.franchiseProfileImage, this.newsImage, this.newsDescription}) : super(key: key);

  @override
  _NewsContainerState createState() => _NewsContainerState();
}

class _NewsContainerState extends State<NewsContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildNewsHeader(),
          _buildNewsBody(),
          _buildNewsDescription(),
        ],
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
              NetworkImage(widget.franchiseProfileImage),
              radius: MediaQuery.of(context).size.width * (3 / 80),
            ),
          ),
          Container(
            width: 10,
          ),
          Container(
            child: Text(
              widget.franchiseName,
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
        widget.newsImage,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
      ),
    );
  }

  Widget _buildNewsDescription() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  widget.franchiseName,
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
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RoutePaths.NewsDetail);
                  },
                  child: ExtendedText(
                    widget.newsDescription,
                    maxLines: 2,
                    textAlign: TextAlign.justify,
                    overFlowTextSpan: OverFlowTextSpan(
                      text: " ... more",
                      style: TextStyle(color: Colors.black45),
                    ),
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

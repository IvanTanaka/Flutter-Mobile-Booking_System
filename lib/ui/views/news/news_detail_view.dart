import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:member_apps/base_widget.dart';
import 'package:member_apps/core/viewmodels/views/news/news_detail_view_model.dart';
import 'package:member_apps/router.dart';
import 'package:member_apps/service_locator.dart';
import 'package:member_apps/ui/shared_colors.dart';

class NewsDetailView extends StatefulWidget {
  final String newsId;

  const NewsDetailView({Key key, this.newsId}) : super(key: key);
  @override
  _NewsDetailViewState createState() => _NewsDetailViewState();
}

class _NewsDetailViewState extends State<NewsDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BaseWidget<NewsDetailViewModel>(
            onModelReady: (NewsDetailViewModel viewModel) async {
              await viewModel.loadNewsDetail(newsId: widget.newsId);
            },
            model: locator<NewsDetailViewModel>(),
            builder:
                (BuildContext context, NewsDetailViewModel viewModel, Widget child) {
              return _buildBody(viewModel);
            }
        )
    );
  }

  Widget _buildBody(NewsDetailViewModel viewModel) {
    return Container(
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: _buildNewsDetailTop(viewModel),
          ),
          Expanded(child: _buildNewsDetailBody(viewModel)),
        ],
      ),
    );
  }

  Widget _buildNewsDetailTop(NewsDetailViewModel viewModel) {
    return Stack(
      children: <Widget>[
        new ClipRect(
          child: new FittedBox(
            fit: BoxFit.cover,
            alignment: Alignment.center,
            child: new Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .width / 2,
              child:
              Image.network(
                viewModel.newsDetail.imagePath,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
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
            ],
          ),
        )
      ],
    );
  }

  Widget _buildNewsDetailBody(NewsDetailViewModel viewModel) {
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
              viewModel.newsDetail.franchise.name,
              style: Theme
                  .of(context)
                  .textTheme
                  .title
                  .merge(TextStyle(color: SharedColors.txtColor)),
            ),
          ),
          Divider(
            color: Colors.grey[500],
          ),
          _buildNewsDetailDescription(viewModel),
          _buildNewsDetailLocations(viewModel),
          Container(
            height: 20,
          )
        ],
      ),
    );
  }

  Widget _buildNewsDetailDescription(NewsDetailViewModel viewModel) {
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
            style: Theme
                .of(context)
                .textTheme
                .title
                .merge(TextStyle(fontWeight: FontWeight.w600, color: SharedColors.primaryColor)),
          ),
          Container(
            height: 5,
          ),
          Text(
            viewModel.newsDetail.description,
            style: Theme
                .of(context)
                .textTheme
                .body1,
          ),
          Container(
            height: 10,
          )
        ],
      ),
    );
  }

//  Widget _buildNewsDetailTermsAndConditions() {
//    return Container(
//      margin: EdgeInsets.only(left: 10, right: 10),
//      child: Column(
//        crossAxisAlignment: CrossAxisAlignment.start,
//        children: <Widget>[
//          Container(
//            height: 10,
//          ),
//          Text("Terms & Conditions",
//              style: Theme
//                  .of(context)
//                  .textTheme
//                  .subhead
//                  .merge(TextStyle(fontWeight: FontWeight.w600))),
//          ListView.builder(
//              shrinkWrap: true,
//              padding: EdgeInsets.only(top: 5),
//              physics: NeverScrollableScrollPhysics(),
//              itemCount: 5,
//              itemBuilder: (BuildContext context, int index) {
//                return Container(
//                  child: Row(
//                    children: <Widget>[
//                      Icon(
//                        FontAwesomeIcons.solidCircle,
//                        size: 7,
//                      ),
//                      Container(
//                        width: 5,
//                      ),
//                      Text("TermsAndConditions[index]"),
//                    ],
//                  ),
//                );
//              }),
//          Container(
//            height: 10,
//          )
//        ],
//      ),
//    );
//  }

  Widget _buildNewsDetailLocations(NewsDetailViewModel viewModel) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: viewModel.newsDetail.branches.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RoutePaths.OrderFoodStore, arguments: viewModel.newsDetail.branches[index].id);
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
                              viewModel.newsDetail.branches[index].name,
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
                                child: Text(viewModel.newsDetail.branches[index].address),
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
                                child: Text(viewModel.newsDetail.branches[index].phoneNumber),
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
}

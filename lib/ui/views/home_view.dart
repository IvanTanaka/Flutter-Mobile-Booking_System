import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:member_apps/base_widget.dart';
import 'package:member_apps/core/models/service_menu_model.dart';
import 'package:member_apps/core/viewmodels/views/home_view_model.dart';
import 'package:member_apps/router.dart';
import 'package:member_apps/service_locator.dart';
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
      body: BaseWidget<HomeViewModel>(
          model: locator<HomeViewModel>(),
          builder: (BuildContext context, HomeViewModel viewModel, Widget child){
            return _buildBody(viewModel);
          },
      ),
    );
  }

  Widget _buildBody(HomeViewModel viewModel) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildWalletContainer(viewModel),
            Container(
              height: 20,
            ),
            _buildListService(viewModel),
            Container(
              height: 50,
            ),
            _buildLatestNews(viewModel)
          ],
        ),
      ),
    );
  }

  Widget _buildWalletContainer(HomeViewModel viewModel) {
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

  Widget _buildListService(HomeViewModel viewModel) {
    return Container(
      child: Column(
        children: <Widget>[
//          Container(
//            child: Text("Start Ordering", style: Theme.of(context).textTheme.headline.merge(TextStyle(color: SharedColors.primaryColor)),),
//          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Material(
              borderRadius: BorderRadius.circular(5),
              elevation: 3,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true, crossAxisCount: 4,
                  // Generate 100 widgets that display their index in the List.
                  children: List.generate(viewModel.serviceMenus.length, (index) {
                    return _buildServiceMenu(serviceMenuModel: viewModel.serviceMenus[index]);
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceMenu({ServiceMenuModel serviceMenuModel}){
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, RoutePaths.SearchFranchise, arguments: serviceMenuModel.type);
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 30,
              backgroundImage:
//          TODO replace with AssetImage(serviceItemModel.imagePath)
              NetworkImage(PrototypeConstant.FRANCHISE_PROFILE_IMAGE),
            ),
            Text(
              serviceMenuModel.name,
              style: Theme.of(context).textTheme.body2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLatestNews(HomeViewModel viewModel) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Latest News",
              style: Theme.of(context).textTheme.subhead.merge(TextStyle(color: SharedColors.primaryColor)),
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

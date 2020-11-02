import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:member_apps/base_widget.dart';
import 'package:member_apps/core/models/service_menu_model.dart';
import 'package:member_apps/core/viewmodels/views/home_view_model.dart';
import 'package:member_apps/router.dart';
import 'package:member_apps/service_locator.dart';
import 'package:member_apps/ui/shared_colors.dart';
import 'package:member_apps/ui/views/news/widgets/news_container.dart';
import 'package:member_apps/ui/widgets/shared_button.dart';
import 'package:member_apps/ui/widgets/shared_carousel.dart';
import 'package:member_apps/ui/widgets/wallet/wallet_container.dart';

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
        automaticallyImplyLeading: false,
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
        onModelReady: (HomeViewModel viewModel) async {
          await viewModel.loadNews();
        },
        builder: (BuildContext context, HomeViewModel viewModel, Widget child) {
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
            Container(
              height: 5,
            ),
            _buildSearchBar(),
            Container(
              height: 18,
            ),
            _buildCarousel(),
            Container(
              height: 35,
            ),
            _buildLabel(),
            Container(
              height: 10,
            ),
            _buildListRestaurants(),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel() {
    return Container(
      margin: EdgeInsets.only(left: 0.1 * MediaQuery.of(context).size.width),
      child: Text(
        "All Restaurants",
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
      ),
    );
  }

  _buildListRestaurants() {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) =>
            _buildRestaurant(index),
      ),
    );
  }

  Widget _buildRestaurant(int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 27, vertical: 7.5),
      child: Card(
        child: Container(
          margin: EdgeInsets.all(15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(right: 15),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    "https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
                    width: MediaQuery.of(context).size.width * 0.23,
                    height: MediaQuery.of(context).size.width * 0.23,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        "Restaurant Name",
                        style:
                            TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                    ),
                    Container(
                      height: 3,
                    ),
                    Container(
                      child: Text(
                        "Restaurant Category",
                        style:
                            TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                      ),
                    ),
                    Container(
                      height: 6,
                    ),
                    Container(
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.mapMarkerAlt,
                            size: 12,
                          ),
                          Text(
                            "rest_distance",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 2,
                    ),
                    Container(
                      child: Text(
                        "Restaurant Address",
                        style:
                            TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: SharedColors.tenPercentBlackColor,
            blurRadius: 10,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: TextFormField(
        cursorColor: SharedColors.primaryColor,
        onChanged: (String value) {
          if (value.length > 2) {
            setState(() {});
          }
        },
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          contentPadding: EdgeInsets.only(left: 27),
          hintText: "What do you want to eat today?",
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(color: Colors.transparent, width: 0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(color: Colors.transparent, width: 0),
          ),
        ),
      ),
    );
  }

  Widget _buildCarousel() {
    return SharedCarousel();
  }
}

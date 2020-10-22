import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
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
            Container(height: 5,),
            _buildSearchBar(),
            Container(height: 18,),
            _buildCarousel(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(){
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
          if(value.length>2){
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
            borderSide: BorderSide(
                color: Colors.transparent,
                width: 0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(
                color: Colors.transparent,
                width: 0),
          ),
        ),
      ),
    );
  }


  Widget _buildCarousel(){
    return SharedCarousel();

  }


}

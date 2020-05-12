import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:member_apps/base_widget.dart';
import 'package:member_apps/core/models/topup_model.dart';
import 'package:member_apps/core/viewmodels/views/topup/topup_home_view_model.dart';
import 'package:member_apps/router.dart';
import 'package:member_apps/service_locator.dart';
import 'package:member_apps/ui/shared_colors.dart';
import 'package:member_apps/ui/widgets/shared_button.dart';
import 'package:member_apps/ui/widgets/wallet/wallet_container.dart';

class TopupHomeView extends StatefulWidget {
  @override
  _TopupHomeViewState createState() => _TopupHomeViewState();
}

class _TopupHomeViewState extends State<TopupHomeView> {
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
                "Wallet",
              )
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        height: 70,
        child: SharedButton(
          onTap: (){
            Navigator.pushNamed(context, RoutePaths.Topup);
          },
          txtFontSize: 20,
          text: "Top Up",
        ),
      ),
      body: BaseWidget<TopupHomeViewModel>(
        onModelReady: (TopupHomeViewModel viewModel) async {
          await viewModel.loadHistories();
        },
        model: locator<TopupHomeViewModel>(),
        builder: (BuildContext context, TopupHomeViewModel viewModel, Widget child){
          return _buildBody(viewModel);
        },
      ),
    );
  }

  Widget _buildBody(TopupHomeViewModel viewModel) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildWalletContainer(viewModel),
            Container(
              height: 20,
            ),
            _buildTopUpHistory(viewModel),
          ],
        ),
      ),
    );
  }

  Widget _buildWalletContainer(TopupHomeViewModel viewModel) {
    return WalletContainer();
  }
  Widget _buildTopUpHistory(TopupHomeViewModel viewModel){
    return viewModel.busy?Container():(viewModel.topups.length>0)?Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Recent Top Up",
              style: Theme.of(context).textTheme.subhead.merge(TextStyle(color: SharedColors.primaryColor)),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Material(
              borderRadius: BorderRadius.circular(3),
              elevation: 1,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: (viewModel.topups.length>3)?4:viewModel.topups.length,
                  itemBuilder: (BuildContext context, int index) {
                    return (index+1<4)?_buildTopUpHistoryContainer(viewModel.topups[index])
                    : GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, RoutePaths.TopupHistory);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Text("load more...", style: TextStyle(color: SharedColors.linkColor),),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    ):Container();
  }

  Widget _buildTopUpHistoryContainer(TopupModel model){
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, RoutePaths.TopupDetail, arguments: model.id);
      },
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Material(
            elevation: 1,
            borderRadius: BorderRadius.circular(5),
            child: Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Text(model.amount, style:Theme.of(context).textTheme.body2.merge(TextStyle(fontSize: 20))),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        child: Text(model.topUpDate),
                      ),
                      Container(
                        child: Text(model.topUpTime),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
    );
  }
}

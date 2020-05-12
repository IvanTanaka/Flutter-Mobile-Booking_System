import 'package:flutter/material.dart';
import 'package:member_apps/base_widget.dart';
import 'package:member_apps/core/viewmodels/views/topup/topup_detail_view_model.dart';
import 'package:member_apps/service_locator.dart';
import 'package:member_apps/ui/shared_colors.dart';
import 'package:member_apps/ui/widgets/shared_loading_page.dart';

class TopupDetailView extends StatefulWidget {
  final String topUpId;
  const TopupDetailView({Key key, this.topUpId}) : super(key: key);

  @override
  _TopupDetailViewState createState() => _TopupDetailViewState();
}

class _TopupDetailViewState extends State<TopupDetailView> {

  @override
  Widget build(BuildContext context) {
    return BaseWidget<TopupDetailViewModel>(
      model: locator<TopupDetailViewModel>(),
      onModelReady: (TopupDetailViewModel viewModel) async {
        await viewModel.getTopUpDetail(id: widget.topUpId);
      },
      builder: (BuildContext context, TopupDetailViewModel viewModel, Widget child) {
        return WillPopScope(
          onWillPop: () async {
            await viewModel.loadTopup();
            return Future.value(true);
          },
          child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                elevation: 1,
                backgroundColor: SharedColors.scaffoldColor,
                title: Text(
                  "Top Up",
                ),
              ),
              body: viewModel.busy?SharedLoadingPage():_buildBody(viewModel)),
        );
      },
    );
  }

  Widget _buildBody(TopupDetailViewModel viewModel) {
    return Center(
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildTopUpAmount(viewModel),
              _buildTopUpVirtualAccount(viewModel),
              Container(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopUpAmount(TopupDetailViewModel viewModel){
    return Container(
      alignment: Alignment.center,
      child:Column(
        children: <Widget>[
          Container(
            child: Text(
              viewModel.topupModel.amount,
              style: TextStyle(
                  fontSize: 30
              ),
            ),
          ),
        ],
      ) ,
    );
  }

  Widget _buildTopUpVirtualAccount(TopupDetailViewModel viewModel){
    return Container(
      alignment: Alignment.center,
      child:Column(
        children: <Widget>[
          Container(
            child: Text("BCA Virtual Account"),
          ),
          Container(
            child: Text(
              viewModel.topupModel.vaNumber,
              style: TextStyle(
                fontSize: 30
              ),
            ),
          ),
          Container(
            child: Text(
              viewModel.topupModel.status,
              style: TextStyle(
                  fontSize: 30
              ),
            ),
          )
        ],
      ) ,
    );
  }
}

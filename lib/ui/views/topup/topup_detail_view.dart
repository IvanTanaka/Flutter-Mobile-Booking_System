import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:flutter/material.dart';
import 'package:member_apps/base_widget.dart';
import 'package:member_apps/core/constants/top_up_status.dart';
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
      builder:
          (BuildContext context, TopupDetailViewModel viewModel, Widget child) {
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
              body:
                  viewModel.busy ? SharedLoadingPage() : _buildBody(viewModel)),
        );
      },
    );
  }

  Widget _buildBody(TopupDetailViewModel viewModel) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 20,
            ),
            _buildTopUpVirtualAccount(viewModel),
            _buildTopUpAmount(viewModel),
            _buildTopUpStatus(viewModel),
            Container(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopUpAmount(TopupDetailViewModel viewModel) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Container(
            child: Text(
              viewModel.topupModel.amount,
              style: TextStyle(
                fontSize: 27,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopUpVirtualAccount(TopupDetailViewModel viewModel) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Image.asset(
                    "assets/images/bca_logo.png",
                    height: 30,
                  ),
                ),
                Container(
                  width: 10,
                ),
                Text(
                  "Virtual Account",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 2,
            height: 35,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: SelectableText(
                  viewModel.topupModel.vaNumber,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: SharedColors.accentColor),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: GestureDetector(
                  onTap: (){
                    ClipboardManager.copyToClipBoard(viewModel.topupModel.vaNumber);
                  },
                  child: Container(
                    child: Icon(Icons.content_copy),
                  ),
                ),
              )
            ],
          ),
          Divider(
            thickness: 2,
            height: 35,
          ),
        ],
      ),
    );
  }

  Widget _buildTopUpStatus(TopupDetailViewModel viewModel) {
    switch (viewModel.topupModel.status) {
      case TopUpStatus.FAILED:
        return Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 120, vertical: 50),
                  child: Image.asset(
                    "assets/images/failed_icon.png",
                  )),
              Container(
                child: Text(
                  "FAILED",
                  style: TextStyle(
                      fontSize: 48,
                      color: SharedColors.statusFailed,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        );
        break;

      case TopUpStatus.PENDING:
        return Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 20,
              ),
              Container(
                child: Text(
                  "Waiting for Transfer",
                  style: TextStyle(
                      fontSize: 30,
                      color: SharedColors.statusWaiting,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        );
        break;

      case TopUpStatus.SUCCESS:
        return Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 120, vertical: 50),
                  child: Image.asset(
                    "assets/images/success_icon.png",
                  )),
              Container(
                child: Text(
                  "SUCCESS",
                  style: TextStyle(
                      fontSize: 48,
                      color: SharedColors.statusSuccess,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        );
        break;
      default:
        return Container();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:member_apps/base_widget.dart';
import 'package:member_apps/core/models/topup_model.dart';
import 'package:member_apps/core/viewmodels/views/topup/topup_history_view_model.dart';
import 'package:member_apps/router.dart';
import 'package:member_apps/service_locator.dart';
import 'package:member_apps/ui/shared_colors.dart';

class TopupHistoryView extends StatefulWidget {
  @override
  _TopupHistoryViewState createState() => _TopupHistoryViewState();
}

class _TopupHistoryViewState extends State<TopupHistoryView> {

  TopupHistoryViewModel _viewModel = locator<TopupHistoryViewModel>();
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        await _viewModel.loadHistories();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<TopupHistoryViewModel>(
      model: _viewModel,
      onModelReady: (TopupHistoryViewModel viewModel) async {
        await viewModel.loadHistories();
      },
      builder: (BuildContext context, TopupHistoryViewModel viewModel, Widget child) {
        return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: 1,
              backgroundColor: SharedColors.scaffoldColor,
              title: Text(
                "Top Up History",
              ),
            ),
            body: _buildBody(viewModel));
      },
    );
  }

  Widget _buildBody(TopupHistoryViewModel viewModel) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        child: ListView.builder(
          controller: _scrollController,
          itemCount: viewModel.topups.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildTopUpHistoryContainer(viewModel.topups[index]);
          },
        ),
      );
  }

  Widget _buildTopUpHistoryContainer(TopupModel model){
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, RoutePaths.TopupDetail, arguments: model.id);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Material(
          elevation: 3,
          borderRadius: BorderRadius.circular(5),
          child: Container(
            padding: EdgeInsets.all(20),
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

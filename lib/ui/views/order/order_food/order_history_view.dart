import 'package:flutter/material.dart';
import 'package:member_apps/base_widget.dart';
import 'package:member_apps/core/models/order_model.dart';
import 'package:member_apps/core/services/helper.dart';
import 'package:member_apps/core/viewmodels/views/order/order_history_view_model.dart';
import 'package:member_apps/router.dart';
import 'package:member_apps/service_locator.dart';
import 'package:member_apps/ui/shared_colors.dart';
import 'package:member_apps/ui/widgets/shared_loading_page.dart';

class OrderHistoryView extends StatefulWidget {
  @override
  _OrderHistoryViewState createState() => _OrderHistoryViewState();
}

class _OrderHistoryViewState extends State<OrderHistoryView> {
  ScrollController _scrollController = new ScrollController();

  OrderHistoryViewModel _viewModel = locator<OrderHistoryViewModel>();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        await _viewModel.loadOrderHistories();
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
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          elevation: 1,
          backgroundColor: SharedColors.scaffoldColor,
          title: Text(
            "Activity",
          )),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BaseWidget<OrderHistoryViewModel>(
      onModelReady: (OrderHistoryViewModel viewModel) async {
        await viewModel.loadOrderHistories();
      },
      model: _viewModel,
      builder: (BuildContext context, OrderHistoryViewModel viewModel,
          Widget child) {
        return _viewModel.busy ? SharedLoadingPage() : _buildList(viewModel);
      },
    );
  }

  Widget _buildList(OrderHistoryViewModel viewModel) {
    return Container(
      child: ListView.separated(
        controller: _scrollController,
        itemCount: viewModel.orders.length,
        separatorBuilder: (BuildContext context, int index){
          return Divider();
        },
        itemBuilder: (BuildContext context, int itemCount) {
          return _buildOrderContainer(viewModel.orders[itemCount]);
        },
      ),
    );
  }

  Widget _buildOrderContainer(OrderModel model) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, RoutePaths.OrderFoodDetail, arguments: model.id);
      },
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  model.branch.franchiseName,
                  style: Theme.of(context)
                      .textTheme
                      .title
                      .merge(TextStyle(color: SharedColors.primaryColor)),
                ),
                Text(Helper.formatDate(model.reserveTime,format: "dd MMM yyyy")),
                Text(Helper.formatDate(model.reserveTime,format: "HH:mm")),
              ],
            ),
            Container(
              child: Text(model.status),
            )
          ],
        ),
      ),
    );
  }
}

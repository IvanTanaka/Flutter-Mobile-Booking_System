import 'package:flutter/material.dart';
import 'package:member_apps/base_widget.dart';
import 'package:member_apps/core/constants/order_status.dart';
import 'package:member_apps/core/enumerations/order_food_type.dart';
import 'package:member_apps/core/models/order_detail_model.dart';
import 'package:member_apps/core/services/helper.dart';
import 'package:member_apps/core/viewmodels/views/order/order_food_detail_view_model.dart';
import 'package:member_apps/router.dart';
import 'package:member_apps/service_locator.dart';
import 'package:member_apps/ui/shared_colors.dart';
import 'package:member_apps/ui/widgets/shared_button.dart';
import 'package:member_apps/ui/widgets/shared_loading_page.dart';

class OrderFoodDetailView extends StatefulWidget {
  final String orderId;

  const OrderFoodDetailView({Key key, this.orderId}) : super(key: key);

  @override
  _OrderFoodDetailViewState createState() => _OrderFoodDetailViewState();
}

class _OrderFoodDetailViewState extends State<OrderFoodDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: SharedColors.scaffoldColor,
        title: Text("Order Detail"),
        centerTitle: true,
      ),
      body: BaseWidget<OrderFoodDetailViewModel>(
        model: locator<OrderFoodDetailViewModel>(),
        onModelReady: (OrderFoodDetailViewModel viewModel) async {
          await viewModel.getOrderDetail(id: widget.orderId);
        },
        builder: (BuildContext context, OrderFoodDetailViewModel viewModel,
            Widget child) {
          return WillPopScope(
              onWillPop: () async {
                return Future.value(true);
              },
              child: (viewModel.busy)
                  ? SharedLoadingPage()
                  : _buildBody(viewModel));
        },
      ),
    );
  }

  Widget _buildBody(OrderFoodDetailViewModel viewModel) {
    return Container(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 20,
            ),
            _buildFranchiseName(viewModel),
            Container(
              height: 10,
            ),
            _buildStatus(viewModel),
            Container(
              height: 20,
            ),
            Divider(
              thickness: 1,
            ),
            _buildBookingTime(viewModel),
            Container(
              height: 10,
            ),
            _buildOrderType(viewModel),
            Divider(
              thickness: 1,
            ),
            Container(
              height: 20,
            ),
            _buildOrderDetail(viewModel),
            Container(
              height: 20,
            ),
            _buildTotalPayment(viewModel),
            _buildOrderFooter(viewModel),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingTime(OrderFoodDetailViewModel viewModel) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Text("Order Time", style: Theme.of(context).textTheme.title),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                child: Text(
                  Helper.formatDate(viewModel.orderModel.reserveTime,
                      format: "dd MMM yyyy"),
                  style: Theme.of(context)
                      .textTheme
                      .title
                      .merge(TextStyle(color: SharedColors.accentColor)),
                ),
              ),
              Container(
                child: Text(
                  Helper.formatDate(viewModel.orderModel.reserveTime,
                      format: "HH:mm"),
                  style: Theme.of(context)
                      .textTheme
                      .title
                      .merge(TextStyle(color: SharedColors.accentColor)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderType(OrderFoodDetailViewModel viewModel) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            viewModel.orderModel.orderTypeStr,
            style: Theme.of(context)
                .textTheme
                .title
                .merge(TextStyle(color: SharedColors.primaryColor)),
          ),
          Text((viewModel.orderModel.orderType == OrderFoodType.dineIn)
              ? "${viewModel.orderModel.peopleCount} person(s)"
              : ""),
        ],
      ),
    );
  }

  Widget _buildOrderDetail(OrderFoodDetailViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 10,
        ),
        Container(
          child: ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return _buildProductDetail(
                    viewModel, viewModel.orderModel.orderDetails[index]);
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider();
              },
              itemCount: viewModel.orderModel.orderDetails.length),
        ),
      ],
    );
  }

  Widget _buildFranchiseName(OrderFoodDetailViewModel viewModel) {
    return Container(
      child: Text(
        viewModel.orderModel.branch.franchiseName,
        style: TextStyle(
          fontSize: 23,
        ),
      ),
    );
  }

  Widget _buildStatus(OrderFoodDetailViewModel viewModel) {
    return Container(
      child: Text(
        viewModel.orderModel.statusStr,
        style: TextStyle(
          color: (viewModel.statusColor),
          fontWeight: FontWeight.w500,
          fontSize: 23,
        ),
      ),
    );
  }

  Widget _buildProductDetail(
      OrderFoodDetailViewModel viewModel, OrderDetailModel model) {
    return Container(
      margin: EdgeInsets.only(left: 10, top: 2, bottom: 2, right: 5),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "${model.menu.name}",
                          style: Theme.of(context)
                              .textTheme
                              .body1
                              .merge(TextStyle(fontSize: 18)),
                        ),
                      ),
                      Container(
                        child: Text("${model.formattedPrice} (x${model.qty})"),
                      )
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(right: 10),
                      alignment: Alignment.centerRight,
                      child: Text(
                        "${model.formattedSubtotal}",
                        style: Theme.of(context)
                            .textTheme
                            .body2
                            .merge(TextStyle(fontSize: 20)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalPayment(OrderFoodDetailViewModel viewModel) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Text(
                    "Total",
                    style: Theme.of(context)
                        .textTheme
                        .subhead
                        .merge(TextStyle(fontWeight: FontWeight.w700)),
                  ),
                ),
                Container(
                  child: Text(
                    "${viewModel.orderModel.formattedTotal}",
                    style: Theme.of(context)
                        .textTheme
                        .headline
                        .merge(TextStyle(color: SharedColors.primaryColor)),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildOrderFooter(OrderFoodDetailViewModel viewModel) {
    switch (viewModel.orderModel.status) {
      case OrderStatus.WAITING:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 50,
            ),
            GestureDetector(
              onTap: () async {
                await viewModel.cancelOrder();
                Navigator.pop(context);
              },
              child: Container(
                width: double.infinity,
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Text(
                  "Cancel Order",
                  style: TextStyle(color: SharedColors.disabledColor),
                ),
              ),
            ),
          ],
        );

      case OrderStatus.ACCEPTED:
        return Container(
          margin: EdgeInsets.only(top: 50, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 20,
              ),
              Container(
                child: Text(
                  "Show this to receive your order",
                  style: TextStyle(
                    fontSize: 24,
                    color: SharedColors.primaryColor,
                  ),
                ),
              ),
              Container(
                height: 10,
              ),
              Container(
                child: SharedButton(
                  text: "Finish this order",
                  activeColor: SharedColors.statusSuccess,
                  txtFontSize: 24,
                  onTap: () async {
                    await viewModel.finishOrder();
                    Navigator.pushReplacementNamed(context, RoutePaths.OrderFoodDetail, arguments: widget.orderId);
                  },
                ),
              )
            ],
          ),
        );
    }
    return Container();
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:member_apps/base_widget.dart';
import 'package:member_apps/core/enumerations/order_food_type.dart';
import 'package:member_apps/core/models/order_store_product_model.dart';
import 'package:member_apps/core/services/helper.dart';
import 'package:member_apps/core/viewmodels/views/order/order_food_confirmation_view_model.dart';
import 'package:member_apps/router.dart';
import 'package:member_apps/service_locator.dart';
import 'package:member_apps/ui/shared_colors.dart';
import 'package:member_apps/ui/widgets/library/date_picker/flutter_datetime_picker.dart';
import 'package:member_apps/ui/widgets/shared_button.dart';
import 'package:member_apps/ui/widgets/shared_loading_page.dart';
import 'package:member_apps/ui/widgets/shared_picker_model.dart';
import 'package:member_apps/ui/widgets/wallet/wallet_container.dart';

class OrderFoodConfirmationView extends StatefulWidget {
  final String storeId;

  const OrderFoodConfirmationView({Key key, this.storeId}) : super(key: key);

  @override
  _OrderFoodConfirmationViewState createState() =>
      _OrderFoodConfirmationViewState();
}

class _OrderFoodConfirmationViewState extends State<OrderFoodConfirmationView> {

  TextEditingController _noteController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseWidget<OrderFoodConfirmationViewModel>(
      model: locator<OrderFoodConfirmationViewModel>(),
      builder: (BuildContext context, OrderFoodConfirmationViewModel viewModel,
          Widget child) {
        return viewModel.busy?Scaffold(
          appBar: AppBar(
              elevation: 1,
              backgroundColor: SharedColors.scaffoldColor,
              title: Text("")),
          body: SharedLoadingPage(),
        ):Scaffold(
          appBar: AppBar(
              elevation: 1,
              backgroundColor: SharedColors.scaffoldColor,
              title: Text(viewModel.branchModel.franchiseName)),
          bottomSheet: Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: SharedButton(
              onTap: () async {
                await viewModel.submitOrder(storeId: widget.storeId, note: _noteController.text);
                Navigator.popUntil(context, (route)=>route.isFirst);
                Navigator.pushNamed(context, RoutePaths.OrderFoodDetail, arguments: viewModel.orderId);
              },
              isDisabled: (viewModel.orderDate == null || viewModel.walletAmount < viewModel.totalOrderPrice || viewModel.orderDetail.length<=0),
              disabledText: (viewModel.orderDate == null)?"Choose Your Order Time":(viewModel.walletAmount < viewModel.totalOrderPrice)?"Wallet Balance Not Enough":"Cart Is Empty, Nothing to Order. ",
              isLoading: viewModel.busy,
              text: "Click to Submit Order",
              txtFontSize: 20,
            ),
          ),
          body: _buildBody(viewModel),
        );
      },
    );
  }

  Widget _buildBody(OrderFoodConfirmationViewModel viewModel) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _buildOrderAppointmentContainer(viewModel),
          _buildOrderFoodType(viewModel),
          _buildStoreMenuDetail(viewModel),
          Divider(
            height: 20,
            color: Colors.black,
          ),
          _buildTotalPayment(viewModel),
          Container(
            height: 10,
          ),
          _buildNote(viewModel),
          WalletContainer(),
          Container(
            height: 170,
          ),

        ],
      ),
    );
  }
  Widget _buildNote(OrderFoodConfirmationViewModel viewModel){
    return Container(
      decoration: BoxDecoration(
          color: SharedColors.primaryColor,
          borderRadius: BorderRadius.circular(5)),
      margin: EdgeInsets.all(10),
      child: Card(
        elevation: 3,
        borderOnForeground: true,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            controller: _noteController,
            maxLines: 2,
            decoration: InputDecoration.collapsed(
                hintText: "Note to seller...",

            ),
          )
        )
      ),
    );
  }

  Future<void> chooseAppointmentTime(
      OrderFoodConfirmationViewModel viewModel) async {
    DatePicker.showPicker(
      context,
      pickerModel: SharedPickerModel(
        currentTime: viewModel.orderDate,
        storeMin: TimeOfDay(hour: viewModel.branchModel.openHour, minute: viewModel.branchModel.openMinute),
        storeMax: TimeOfDay(hour: viewModel.branchModel.closeHour, minute: viewModel.branchModel.closeMinute),
      ),
      onConfirm: (DateTime dateTime) {
        viewModel.orderDate = dateTime;
      },
      theme: DatePickerTheme(
        itemStyle: TextStyle(color: SharedColors.txtAccentColor),
        backgroundColor: SharedColors.accentColor,
        headerColor: SharedColors.accentColor,
        doneStyle: TextStyle(
            color: SharedColors.txtAccentColor,
            fontWeight: FontWeight.w600,
            fontSize: 18),
        containerHeight: 160,
        cancelStyle: TextStyle(
            color: SharedColors.txtAccentColor,
            fontWeight: FontWeight.w600,
            fontSize: 18),
      ),
    );
  }

  Widget _buildOrderAppointmentContainer(
      OrderFoodConfirmationViewModel viewModel) {
    return GestureDetector(
      onTap: () async {
        await chooseAppointmentTime(viewModel);
      },
      child: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: SharedColors.accentColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.transparent),
          ),
          padding: EdgeInsets.symmetric(vertical: 10),
          child: (viewModel.orderDate != null)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      viewModel.orderDateString,
                      style: TextStyle(
                          fontSize: 20, color: SharedColors.txtAccentColor),
                    ),
                    Container(
                      height: 10,
                    ),
                    Text(
                      viewModel.orderTimeString,
                      style: TextStyle(
                          fontSize: 24, color: SharedColors.txtAccentColor),
                    )
                  ],
                )
              : Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Choose order time",
                    style: TextStyle(
                        color: SharedColors.txtAccentColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                )),
    );
  }

  Widget _buildOrderFoodType(OrderFoodConfirmationViewModel viewModel) {
    return Container(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              viewModel.orderFoodType = OrderFoodType.takeAway;
            },
            child: Container(
              color: Colors.transparent,
              child: Row(
                children: <Widget>[
                  Radio<OrderFoodType>(
                      activeColor: SharedColors.primaryColor,
                      value: OrderFoodType.takeAway,
                      groupValue: viewModel.orderFoodType,
                      onChanged: (OrderFoodType value) {
                        viewModel.orderFoodType = OrderFoodType.takeAway;
                      }),
                  Text("Take Away"),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  viewModel.orderFoodType = OrderFoodType.dineIn;
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    children: <Widget>[
                      Radio<OrderFoodType>(
                          activeColor: SharedColors.primaryColor,
                          value: OrderFoodType.dineIn,
                          groupValue: viewModel.orderFoodType,
                          onChanged: (OrderFoodType value) {
                            viewModel.orderFoodType = OrderFoodType.dineIn;
                          }),
                      Text("Dine In"),
                    ],
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(right: 5),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(Icons.person),
                    RawMaterialButton(
                      onPressed: (viewModel.orderFoodType==OrderFoodType.takeAway)?null:() {
                        viewModel.dineInQty--;
                      },
                      child: new Icon(
                        FontAwesomeIcons.minus,
                        color: (viewModel.orderFoodType==OrderFoodType.takeAway)?SharedColors.txtAccentColor:SharedColors.primaryColor,
                        size: 12.0,
                      ),
                      shape: new CircleBorder(),
                      constraints:
                      BoxConstraints(minHeight: 20, minWidth: 20),
                      elevation: (viewModel.orderFoodType==OrderFoodType.takeAway)?0:4,
                      fillColor: (viewModel.orderFoodType==OrderFoodType.takeAway)?SharedColors.btnDisabledColor:Colors.white,
                    ),
                    new Text("${viewModel.dineInQty}",
                        style: new TextStyle(fontSize: 16.0, color: (viewModel.orderFoodType==OrderFoodType.takeAway)?SharedColors.btnDisabledColor:SharedColors.txtColor)),
                    Container(width: 5,),

                    RawMaterialButton(
                      onPressed: (viewModel.orderFoodType==OrderFoodType.takeAway)?null:() {
                        viewModel.dineInQty++;
                      },
                      child: new Icon(
                        FontAwesomeIcons.plus,
                        color: (viewModel.orderFoodType==OrderFoodType.takeAway)?SharedColors.txtAccentColor:SharedColors.primaryColor,
                        size: 12.0,
                      ),
                      shape: new CircleBorder(),
                      constraints:
                      BoxConstraints(minHeight: 20, minWidth: 20),
                      elevation: (viewModel.orderFoodType==OrderFoodType.takeAway)?0:4,
                      fillColor: (viewModel.orderFoodType==OrderFoodType.takeAway)?SharedColors.btnDisabledColor:Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStoreMenuDetail(OrderFoodConfirmationViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 40,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Order Detail",
            style: Theme.of(context).textTheme.headline,
          ),
        ),
        Container(
          child: ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return _buildProductDetail(
                    viewModel, viewModel.orderDetail[index]);
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider();
              },
              itemCount: viewModel.orderDetail.length),
        ),
      ],
    );
  }

  Widget _buildTotalPayment(OrderFoodConfirmationViewModel viewModel) {
    return Container(
      child: Column(
        children: <Widget>[
//          Container(
//            height: 10,
//          ),
//          Container(
//            margin: EdgeInsets.symmetric(horizontal: 10),
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              children: <Widget>[
//                Container(
//                  child: Text(
//                    "Subtotal",
//                    style: Theme.of(context).textTheme.subhead,
//                  ),
//                ),
//                Container(
//                  child: Text(
//                    "${viewModel.subtotalOrderPrice}",
//                    style: Theme.of(context).textTheme.subhead,
//                  ),
//                )
//              ],
//            ),
//          ),
//          Container(
//            margin: EdgeInsets.symmetric(horizontal: 10),
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              children: <Widget>[
//                Container(
//                  child: Text(
//                    "Tax 10%",
//                    style: Theme.of(context).textTheme.subhead,
//                  ),
//                ),
//                Container(
//                  child: Text(
//                    "${viewModel.taxOrderPrice}",
//                    style: Theme.of(context).textTheme.subhead,
//                  ),
//                )
//              ],
//            ),
//          ),
//          Divider(
//            height: 20,
//            color: Colors.black,
//          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Text(
                    "Total",
                    style: Theme.of(context).textTheme.subhead.merge(TextStyle(fontWeight: FontWeight.w700)),
                  ),
                ),
                Container(
                  child: Text(
                    "${Helper.doubleToMoneyFormat(viewModel.totalOrderPrice.toDouble())}",
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

  Widget _buildProductDetail(
      OrderFoodConfirmationViewModel viewModel, OrderStoreProductModel model) {
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
                  child: Container(
                    child: Text(
                      model.productName,
                      style: Theme.of(context)
                          .textTheme
                          .body1
                          .merge(TextStyle(fontSize: 18)),
                    ),
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
                        "${Helper.doubleToMoneyFormat((model.price * model.qty).toDouble())}",
                        style: Theme.of(context)
                            .textTheme
                            .body2
                            .merge(TextStyle(fontSize: 20)),
                      ),
                    ),
                    Container(
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          RawMaterialButton(
                            onPressed: () {
                              model.minusQty();
                              viewModel.refreshCarts(model);
                            },
                            child: new Icon(
                              FontAwesomeIcons.minus,
                              color: SharedColors.primaryColor,
                              size: 12.0,
                            ),
                            shape: new CircleBorder(),
                            constraints:
                                BoxConstraints(minHeight: 20, minWidth: 20),
                            elevation: 4,
                            fillColor: Colors.white,
                          ),
                          new Text("${model.qty}",
                              style: new TextStyle(fontSize: 16.0)),
                          RawMaterialButton(
                            onPressed: () {
                              model.addQty();
                              viewModel.refreshCarts(model);
                            },
                            child: new Icon(
                              FontAwesomeIcons.plus,
                              color: SharedColors.primaryColor,
                              size: 12.0,
                            ),
                            shape: new CircleBorder(),
                            constraints:
                                BoxConstraints(minHeight: 20, minWidth: 20),
                            elevation: 4,
                            fillColor: Colors.white,
                          ),
                        ],
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
}

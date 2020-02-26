import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:member_apps/base_widget.dart';
import 'package:member_apps/core/models/order_store_product_model.dart';
import 'package:member_apps/core/services/helper.dart';
import 'package:member_apps/core/viewmodels/views/order/order_food_store_view_model.dart';
import 'package:member_apps/router.dart';
import 'package:member_apps/service_locator.dart';
import 'package:member_apps/ui/prototype_constant.dart';
import 'package:member_apps/ui/shared_colors.dart';
import 'package:member_apps/ui/widgets/library/date_picker/flutter_datetime_picker.dart';
import 'package:member_apps/ui/widgets/shared_button.dart';
import 'package:member_apps/ui/widgets/shared_picker_model.dart';

class OrderFoodStoreView extends StatefulWidget {
  @override
  _OrderFoodStoreViewState createState() => _OrderFoodStoreViewState();
}

class _OrderFoodStoreViewState extends State<OrderFoodStoreView> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<OrderFoodStoreViewModel>(
      model: locator<OrderFoodStoreViewModel>(),
      onModelReady: (OrderFoodStoreViewModel viewModel) async {
        await viewModel.getProducts();
      },
      builder: (BuildContext context, OrderFoodStoreViewModel viewModel,
          Widget child) {
        return Scaffold(
          appBar: AppBar(
              elevation: 1,
              backgroundColor: SharedColors.scaffoldColor,
              title: Text("Coco Bop")),

          bottomSheet: Container(
            height: viewModel.carts.length>0?70:0,
            child: SharedButton(
              onTap: (){
                print("Continue Order");
                viewModel.continueOrder();
                Navigator.pushNamed(context, RoutePaths.OrderFoodConfirmation);
              },
              isDisabled: viewModel.orderDate==null,
              disabledText: "Choose The Time",
              text: "${viewModel.carts.length} items on cart - Continue",
            ),
          ),
          body: _buildBody(viewModel),
        );
      },
    );
  }

  Widget _buildBody(OrderFoodStoreViewModel viewModel) {
    return Container(
      child: Column(
        children: <Widget>[
          _buildAppointmentContainer(viewModel),
          Expanded(child: _buildStoreProduct(viewModel)),
        ],
      ),
    );
  }

  Widget _buildAppointmentContainer(OrderFoodStoreViewModel viewModel) {
    return GestureDetector(
      onTap: () async {
        await chooseAppointmentTime(viewModel);
      },
      child: Container(
        color: SharedColors.primaryColor,
        height: 50,
        width: double.infinity,
        child: viewModel.orderDate != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    child: Text(
                      Helper.formatDate(
                        viewModel.orderDate,
                        format: "EE, dd MMM yyyy",
                      ),
                      style: TextStyle(
                          color: SharedColors.txtAccentColor, fontSize: 24),
                    ),
                  ),
                  Container(
                    child: Text(
                      Helper.formatDate(
                        viewModel.orderDate,
                        format: "HH:mm",
                      ),
                      style: TextStyle(
                          color: SharedColors.txtAccentColor, fontSize: 24),
                    ),
                  ),
                ],
              )
            : Container(
                alignment: Alignment.center,
                child: Text(
                  "Choose the time",
                  style: TextStyle(
                      color: SharedColors.txtAccentColor,
                      fontWeight: FontWeight.w600),
                ),
              ),
      ),
    );
  }

  Future<void> chooseAppointmentTime(OrderFoodStoreViewModel viewModel) async {
    DatePicker.showPicker(
      context,
      pickerModel: SharedPickerModel(
        currentTime: viewModel.orderDate,
        storeMin: TimeOfDay(hour: 00, minute: 30),
        storeMax: TimeOfDay(hour: 23, minute: 00),
      ),
      onConfirm: (DateTime dateTime) {
        viewModel.orderDate = dateTime;
      },
      theme: DatePickerTheme(
        itemStyle: TextStyle(color: SharedColors.accentColor),
        headerColor: SharedColors.primaryColor,
        doneStyle: TextStyle(
          color: SharedColors.txtAccentColor,
        ),
        cancelStyle: TextStyle(color: SharedColors.disabledColor),
      ),
    );
  }

  Widget _buildStoreProduct(OrderFoodStoreViewModel viewModel) {
    return Container(
      child: ListView.separated(
          itemCount: viewModel.orderStoreProducts.length+1,
          separatorBuilder: (BuildContext context, int index){
            return Divider();
          },
          itemBuilder: (BuildContext context, int index) {
            return index==viewModel.orderStoreProducts.length?Container(height: 100,):_buildStoreProductItem(viewModel, viewModel.orderStoreProducts[index]);
          }),
    );
  }

  Widget _buildStoreProductItem(OrderFoodStoreViewModel viewModel, OrderStoreProductModel model) {
    return Container(
      height: 120,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Image.network(
              model.imagePath,
              height: 20,
              width: 20,
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 4,
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
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(right: 10),
                            alignment: Alignment.centerRight,
                            child: Text(
                              "${model.price}",
                              style: Theme.of(context)
                                  .textTheme
                                  .body2
                                  .merge(TextStyle(fontSize: 20)),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 10),
                            alignment: Alignment.centerRight,
                            child: Text(
                              "${model.discountPrice}",
                              style: Theme.of(context)
                                  .textTheme
                                  .body1
                                  .merge(TextStyle(
                                  fontWeight: FontWeight.w300,
                                  decoration:
                                  TextDecoration.lineThrough)),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: ExtendedText(
                        model.description,
                        style: Theme.of(context).textTheme.caption,
                        maxLines: 3,
                        overFlowTextSpan: OverFlowTextSpan(
                          text: " ...",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        child: Center(
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              RawMaterialButton(
                                onPressed: () {
                                  model.minusQty();
                                  viewModel.refreshCarts(model);
                                },
                                child: new Icon(
                                  FontAwesomeIcons.minus,
                                  color: SharedColors.accentColor,
                                  size: 14.0,
                                ),
                                shape: new CircleBorder(),
                                constraints: BoxConstraints(minHeight: 30, minWidth: 30),
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
                                  color: SharedColors.accentColor,
                                  size: 14.0,
                                ),
                                shape: new CircleBorder(),
                                constraints: BoxConstraints(minHeight: 30, minWidth: 30),
                                elevation: 4,
                                fillColor: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

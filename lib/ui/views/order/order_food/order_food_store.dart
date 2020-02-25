import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:member_apps/base_widget.dart';
import 'package:member_apps/core/services/helper.dart';
import 'package:member_apps/core/viewmodels/views/order/order_food_store_view_model.dart';
import 'package:member_apps/service_locator.dart';
import 'package:member_apps/ui/prototype_constant.dart';
import 'package:member_apps/ui/shared_colors.dart';
import 'package:member_apps/ui/widgets/library/date_picker/flutter_datetime_picker.dart';
import 'package:member_apps/ui/widgets/shared_picker_model.dart';

class OrderFoodStore extends StatefulWidget {
  @override
  _OrderFoodStoreState createState() => _OrderFoodStoreState();
}

class _OrderFoodStoreState extends State<OrderFoodStore> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<OrderFoodStoreViewModel>(
      model: locator<OrderFoodStoreViewModel>(),
      builder: (BuildContext context, OrderFoodStoreViewModel viewModel,
          Widget child) {
        return Scaffold(
          appBar: AppBar(
              elevation: 1,
              backgroundColor: SharedColors.scaffoldColor,
              title: Text("Coco Bop")),
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
          Expanded(child: _buildStoreProduct()),
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
                        format: "dd MMM, yyyy",
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
//    DatePicker.showDateTimePicker(context,
//      minTime: viewModel.minOrderDate,
//      maxTime: viewModel.maxOrderDate,
//      onConfirm: (DateTime dateTime) {
//        print("Tes ${dateTime.toString()}");
//        viewModel.orderDate = dateTime;
//      },
//      theme: DatePickerTheme(
//        itemStyle: TextStyle(color: SharedColors.accentColor),
//        headerColor: SharedColors.primaryColor,
//        doneStyle: TextStyle(
//          color: SharedColors.txtAccentColor,
//        ),
//        cancelStyle: TextStyle(color: SharedColors.disabledColor),
//      ),
//    );

    DatePicker.showPicker(
      context,
      pickerModel: SharedPickerModel(
        currentTime: viewModel.orderDate,
        storeMin: TimeOfDay(hour: 00, minute: 30),
        storeMax: TimeOfDay(hour: 23, minute: 00),
      ),
      onConfirm: (DateTime dateTime) {
        print("Tes ${dateTime.toString()}");
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

  Widget _buildStoreProduct() {
    return Container(
      child: ListView.builder(
          itemCount: 20,
          itemBuilder: (BuildContext context, int index) {
            return _buildStoreProductItem();
          }),
    );
  }

  Widget _buildStoreProductItem() {
    return Column(
      children: <Widget>[
        Container(
          height: 120,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Image.network(
                  PrototypeConstant.FRANCHISE_PROFILE_IMAGE,
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
                              "Product A Product A Product A Product A",
                              style: Theme.of(context)
                                  .textTheme
                                  .body1
                                  .merge(TextStyle(fontSize: 20)),
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
                                  "1.000.000.000",
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
                                  "9.999.999.999",
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
                    Container(
                      padding: EdgeInsets.only(right: 40),
                      child: ExtendedText(
                        "ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ ABCDEFGHIJKLMNOPQRSTUVWXYZ ABCDEFGHIJKLMNOPQRSTUVWXYZ ABCDEFGHIJKLMNOPQRSTUVWXYZ",
                        style: Theme.of(context).textTheme.caption,
                        maxLines: 3,
                        overFlowTextSpan: OverFlowTextSpan(
                          text: " ...",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider()
      ],
    );
  }
}

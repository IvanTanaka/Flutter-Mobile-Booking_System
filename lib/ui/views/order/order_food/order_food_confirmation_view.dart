import 'package:flutter/material.dart';
import 'package:member_apps/base_widget.dart';
import 'package:member_apps/core/viewmodels/views/order/order_food_confirmation_view_model.dart';
import 'package:member_apps/service_locator.dart';
import 'package:member_apps/ui/shared_colors.dart';
import 'package:member_apps/ui/widgets/shared_button.dart';

class OrderFoodConfirmationView extends StatefulWidget {
  @override
  _OrderFoodConfirmationViewState createState() => _OrderFoodConfirmationViewState();
}

class _OrderFoodConfirmationViewState extends State<OrderFoodConfirmationView> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<OrderFoodConfirmationViewModel>(
      model: locator<OrderFoodConfirmationViewModel>(),
      builder: (BuildContext context, OrderFoodConfirmationViewModel viewModel,
          Widget child) {
        return Scaffold(
          appBar: AppBar(
              elevation: 1,
              backgroundColor: SharedColors.scaffoldColor,
              title: Text("Coco Bop")),

          bottomSheet: Container(
            child: SharedButton(
              onTap: (){
                print("Submit Order");
              },
              isLoading: viewModel.busy,
              text: "Click to Order",
            ),
          ),
          body: _buildBody(viewModel),
        );
      },
    );
  }

  Widget _buildBody(OrderFoodConfirmationViewModel viewModel){
    return Container(

    );
  }


}

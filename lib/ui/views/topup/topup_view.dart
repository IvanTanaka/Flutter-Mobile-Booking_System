import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:member_apps/base_widget.dart';
import 'package:member_apps/core/viewmodels/views/topup/topup_view_model.dart';
import 'package:member_apps/router.dart';
import 'package:member_apps/service_locator.dart';
import 'package:member_apps/ui/shared_colors.dart';
import 'package:member_apps/ui/widgets/shared_button.dart';

class TopupView extends StatefulWidget {
  @override
  _TopupViewState createState() => _TopupViewState();
}

class _TopupViewState extends State<TopupView> {
  TextEditingController _topupController = MoneyMaskedTextController(
      precision: 0, decimalSeparator: "", leftSymbol: "Rp ");

  @override
  Widget build(BuildContext context) {
    return BaseWidget<TopupViewModel>(
      model: locator<TopupViewModel>(),
      builder: (BuildContext context, TopupViewModel viewModel, Widget child) {
        return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: 1,
              backgroundColor: SharedColors.scaffoldColor,
              title: Text(
                "Top Up",
              ),
            ),
            bottomSheet: _buildSubmitButton(viewModel),
            body: _buildBody(viewModel));
      },
    );
  }

  Widget _buildSubmitButton(TopupViewModel viewModel) {
    return Container(
      height: 70,
      child: SharedButton(
        activeColor: SharedColors.accentColor,
        isDisabled: viewModel.topupButtonIsDisabled,
        onTap: () async {
          await viewModel.topUp();
          Navigator.pushReplacementNamed(context, RoutePaths.TopupDetail, arguments: viewModel.topUpId);
        },
        txtFontSize: 20,
        text: "Top Up",
      ),
    );
  }

  Widget _buildBody(TopupViewModel viewModel) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildTopUpTextField(viewModel),
            Container(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopUpTextField(TopupViewModel viewModel) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Top Up Amount",
            style: Theme.of(context)
                .textTheme
                .subhead
                .merge(TextStyle(color: SharedColors.txtColor)),
          ),
          TextField(
            controller: _topupController,
            decoration: InputDecoration(
              labelText: "min. Rp 10.000",
              hasFloatingPlaceholder: false,
              hintText: "min. Rp 10.000",
            ),
            onChanged: (String value) {
              viewModel.validateTopUp(_topupController.text);
            },
            inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
          ),
          Container(
              alignment: Alignment.topRight,
              child: Text(
                "* (Min. Rp 10.000)",
                style: Theme.of(context).textTheme.caption,
              ))
        ],
      ),
    );
  }
}

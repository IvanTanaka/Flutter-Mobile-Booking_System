import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:member_apps/base_widget.dart';
import 'package:member_apps/core/viewmodels/widgets/wallet/wallet_container_view_model.dart';
import 'package:member_apps/service_locator.dart';
import 'package:member_apps/ui/shared_colors.dart';

class WalletContainer extends StatefulWidget {
  @override
  _WalletContainerState createState() => _WalletContainerState();
}

class _WalletContainerState extends State<WalletContainer> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<WalletContainerViewModel>(
      model: locator<WalletContainerViewModel>(),
      onModelReady: (WalletContainerViewModel viewModel) async {
        await viewModel.loadWallet();
      },
      builder: (BuildContext context, WalletContainerViewModel viewModel, Widget child){
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(5),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  height: 50,
                  decoration: BoxDecoration(
                    color: SharedColors.accentColor,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
                  ),
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.wallet,
                          size: 20,
                          color: SharedColors.txtAccentColor,
                        ),
                        Container(
                          width: 10,
                        ),
                        Text(
                          "Balance",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: SharedColors.txtAccentColor),
                        ),
                        Expanded(
                          child: (viewModel.busy)?_buildLoadingIndicator(): Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              viewModel.walletAmount,
                              style: TextStyle(
                                  color: SharedColors.txtAccentColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 4,
                ),
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: SharedColors.accentColor,
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(5)),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoadingIndicator(){
    return CircularProgressIndicator();
  }
}

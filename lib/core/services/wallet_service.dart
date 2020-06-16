import 'dart:convert';

import 'package:member_apps/core/constants/network_code.dart';
import 'package:member_apps/core/services/api.dart';
import 'package:member_apps/core/services/helper.dart';

class WalletService{

  Api _api;
int walletAmount;
  String get walletAmountFormatted {
    return Helper.doubleToMoneyFormat(walletAmount.toDouble());
  }

  WalletService({Api api}){
    this._api =api;
  }

  Future<String> loadWallet() async{
    final response = await _api.get(
      url:
      "v1/wallet",
    );
    final resDecoded = json.decode(response);
    if(resDecoded["code"]==NetworkCode.SUCCESS){
      walletAmount = resDecoded['result']['amount'];
      return walletAmountFormatted;
    }else{
      return "Error";
    }
  }
}
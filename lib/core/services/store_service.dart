import 'dart:convert';

import 'package:member_apps/core/constants/network_code.dart';
import 'package:member_apps/core/constants/booking_service_menu_name.dart';
import 'package:member_apps/core/enumerations/booking_service_type.dart';
import 'package:member_apps/core/models/branch_model.dart';
import 'package:member_apps/core/models/search_store_model.dart';
import 'package:member_apps/core/services/api.dart';

class StoreService{


  Api _api;
  BranchModel branchModel;

  StoreService({Api api}){
    this._api =api;
  }

  Future<List<SearchStoreModel>> getStoresByFilter({BookingServiceType type, String name, int page=1}) async{
    String typeStr = "";
    switch(type){
      case BookingServiceType.food:
        typeStr = BookingServiceMenuName.FOOD;
        break;
      case BookingServiceType.barber:
        typeStr = BookingServiceMenuName.BARBER;
        break;
      case BookingServiceType.karaoke:
        typeStr = BookingServiceMenuName.KARAOKE;
        break;
      case BookingServiceType.sport:
        typeStr = BookingServiceMenuName.SPORT;
        break;
    }
    final response = await _api.get(
      url:
      "v1/store?type=$typeStr${(name!=null)?"&name=$name":""}&page=$page",
    );
    final resDecoded = json.decode(response);
    if(resDecoded["code"]==NetworkCode.SUCCESS){
      return List<SearchStoreModel>.from(resDecoded["result"]["data"].map((x) => SearchStoreModel.fromJson(x)));
    }else{
      return [];
    }
  }

  Future<BranchModel> getBranchByStoreId(String storeId) async {
    final response = await _api.get(
      url:
      "v1/store/$storeId",
    );
    final resDecoded = json.decode(response);
    if(resDecoded["code"]==NetworkCode.SUCCESS){

      branchModel = BranchModel.fromJson(resDecoded["result"]);
      return branchModel;
    }else{
      branchModel = BranchModel();
      return branchModel;
    }
  }
}
import 'dart:convert';

import 'package:member_apps/core/constants/network_code.dart';
import 'package:member_apps/core/constants/category_name.dart';
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

  Future<List<SearchStoreModel>> getStoresByFilter({BookingServiceCategory type, String name, int page=1}) async{
    String typeStr = "";
    switch(type){
      case BookingServiceCategory.fast_food:
        typeStr = CategoryName.FAST_FOOD;
        break;
      case BookingServiceCategory.sea_food:
        typeStr = CategoryName.SEA_FOOD;
        break;
      case BookingServiceCategory.salad:
        typeStr = CategoryName.SALAD;
        break;
      case BookingServiceCategory.drinks:
        typeStr = CategoryName.DRINKS;
        break;
    }
    final response = await _api.get(
      url:
      "v1/store?category=$typeStr${(name!=null)?"&name=$name":""}&page=$page",
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
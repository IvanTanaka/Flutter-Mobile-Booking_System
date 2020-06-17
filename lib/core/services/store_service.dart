import 'dart:convert';

import 'package:member_apps/core/constants/food_category.dart';
import 'package:member_apps/core/constants/network_code.dart';
import 'package:member_apps/core/constants/category_name.dart';
import 'package:member_apps/core/models/branch_model.dart';
import 'package:member_apps/core/models/search_store_model.dart';
import 'package:member_apps/core/services/api.dart';

class StoreService{


  Api _api;
  BranchModel branchModel;

  StoreService({Api api}){
    this._api =api;
  }

  Future<List<SearchStoreModel>> getStoresByFilter({String foodCategory, String name, int page=1}) async{
    final response = await _api.get(
      url:
      "v1/store?${(foodCategory!=null)?"category=$foodCategory":""}${(name!=null)?"&name=$name":""}&page=$page",
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
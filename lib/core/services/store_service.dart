import 'dart:convert';

import 'package:member_apps/core/constants/network_code.dart';
import 'package:member_apps/core/constants/service_menu_name.dart';
import 'package:member_apps/core/models/branch_model.dart';
import 'package:member_apps/core/models/search_store_model.dart';
import 'package:member_apps/core/models/service_menu_model.dart';
import 'package:member_apps/core/services/api.dart';
import 'package:member_apps/ui/prototype_constant.dart';

class StoreService{

  Api _api;

  StoreService({Api api}){
    this._api =api;
  }

  Future<List<SearchStoreModel>> getStoreByFilter({ServiceType type, String name, int page=1}) async{
    String typeStr = "";
    switch(type){
      case ServiceType.food:
        typeStr = ServiceMenuName.FOOD;
        break;
      case ServiceType.barber:
        typeStr = ServiceMenuName.BARBER;
        break;
      case ServiceType.karaoke:
        typeStr = ServiceMenuName.KARAOKE;
        break;
      case ServiceType.sport:
        typeStr = ServiceMenuName.SPORT;
        break;
    }
//    TODO: Comment This
    await Future.delayed(Duration(seconds: 4));
    return [
      SearchStoreModel(
        id: "23123131",
        franchiseName: "Coco Bop",
        branches: [
          BranchModel(
              branchName: "Coco Bop",
              address: PrototypeConstant.LOREM_IPSUM,
              phoneNumber: "+323 3232 32")
        ],
      ),
      SearchStoreModel(
        id: "321njkk2ni3",
        franchiseName: "Mie Akhun",
        branches: [
          BranchModel(
              branchName: "Cab. S. Parman",
              address: PrototypeConstant.LOREM_IPSUM,
              phoneNumber: "+62 9292929"),
          BranchModel(
            branchName: "Cab. Wahidin",
            address: "Jl. Wahidin No 6",
            phoneNumber: "020 20101010",
          )
        ],
      ),
      SearchStoreModel(
        id: "23123131",
        franchiseName: "Coco Bop",
        branches: [
          BranchModel(
              branchName: "Coco Bop",
              address: PrototypeConstant.LOREM_IPSUM,
              phoneNumber: "+323 3232 32")
        ],
      ),
      SearchStoreModel(
        id: "321njkk2ni3",
        franchiseName: "Mie Akhun",
        branches: [
          BranchModel(
              branchName: "Cab. S. Parman",
              address: PrototypeConstant.LOREM_IPSUM,
              phoneNumber: "+62 9292929"),
          BranchModel(
            branchName: "Cab. Wahidin",
            address: "Jl. Wahidin No 6",
            phoneNumber: "020 20101010",
          )
        ],
      ),
    ];
//    TODO: Uncomment This
//    final response = await _api.get(
//      url:
//      "v1/store?()type=$typeStr${(name!=null)?"name=$name":""}page=$page",
//    );
//    final resDecoded = json.decode(response);
//    if(resDecoded["code"]==NetworkCode.SUCCESS){
//      return List<SearchStoreModel>.from(resDecoded["result"]["data"].map((x) => SearchStoreModel.fromJson(x)));
//    }else{
//      return [];
//    }
  }
}
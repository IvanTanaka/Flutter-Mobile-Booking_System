import 'dart:convert';

import 'package:member_apps/core/constants/network_code.dart';
import 'package:member_apps/core/constants/booking_service_menu_name.dart';
import 'package:member_apps/core/enumerations/booking_service_type.dart';
import 'package:member_apps/core/models/branch_model.dart';
import 'package:member_apps/core/models/order_store_model.dart';
import 'package:member_apps/core/models/search_store_model.dart';
import 'package:member_apps/core/models/service_menu_model.dart';
import 'package:member_apps/core/services/api.dart';
import 'package:member_apps/ui/prototype_constant.dart';

class StoreService{


  Api _api;

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
////    TODO: Comment This
//    await Future.delayed(Duration(seconds: 4));
//    return [
//      SearchStoreModel(
//        id: "23123131",
//        franchiseName: "Coco Bop",
//        branches: [
//          BranchModel(
//              branchName: "Coco Bop",
//              address: PrototypeConstant.LOREM_IPSUM,
//              phoneNumber: "+323 3232 32")
//        ],
//      ),
//      SearchStoreModel(
//        id: "321njkk2ni3",
//        franchiseName: "Mie Akhun",
//        branches: [
//          BranchModel(
//              branchName: "Cab. S. Parman",
//              address: PrototypeConstant.LOREM_IPSUM,
//              phoneNumber: "+62 9292929"),
//          BranchModel(
//            branchName: "Cab. Wahidin",
//            address: "Jl. Wahidin No 6",
//            phoneNumber: "020 20101010",
//          )
//        ],
//      ),
//      SearchStoreModel(
//        id: "23123131",
//        franchiseName: "Coco Bop",
//        branches: [
//          BranchModel(
//              branchName: "Coco Bop",
//              address: PrototypeConstant.LOREM_IPSUM,
//              phoneNumber: "+323 3232 32")
//        ],
//      ),
//      SearchStoreModel(
//        id: "321njkk2ni3",
//        franchiseName: "Mie Akhun",
//        branches: [
//          BranchModel(
//              branchName: "Cab. S. Parman",
//              address: PrototypeConstant.LOREM_IPSUM,
//              phoneNumber: "+62 9292929"),
//          BranchModel(
//            branchName: "Cab. Wahidin",
//            address: "Jl. Wahidin No 6",
//            phoneNumber: "020 20101010",
//          )
//        ],
//      ),
//    ];
////    TODO: Uncomment This
    final response = await _api.get(
      url:
      "v1/store?type=$typeStr${(name!=null)?"&name=$name":""}&page=$page",
    );
    final resDecoded = json.decode(response);
    if(resDecoded["code"]==NetworkCode.SUCCESS){
      return List<SearchStoreModel>.from(resDecoded["data"]["data"].map((x) => SearchStoreModel.fromJson(x)));
    }else{
      return [];
    }
  }

  Future<OrderStoreModel> getOrderStoreByStoreId(String storeId) async {
    return OrderStoreModel(
      id: "010120",
      franchiseName: "Coco Bop",
      branchName: "Lippo",
      address: PrototypeConstant.LOREM_IPSUM,
      phoneNumber: "+6282272675309",
      type: "food"
    );

//    TODO: Uncomment This
//    final response = await _api.get(
//      url:
//      "v1/store/$storeId",
//    );
//    final resDecoded = json.decode(response);
//    if(resDecoded["code"]==NetworkCode.SUCCESS){
//      return OrderStoreModel.fromJson(resDecoded["result"]["data"]);
//    }else{
//      return OrderStoreModel();
//    }
  }
}
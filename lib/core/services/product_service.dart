import 'dart:convert';

import 'package:member_apps/core/constants/network_code.dart';
import 'package:member_apps/core/models/order_store_product_model.dart';
import 'package:member_apps/core/services/api.dart';
import 'package:member_apps/ui/prototype_constant.dart';

class ProductService{

  DateTime orderDate;
  Api _api;

  ProductService({Api api}){
    this._api =api;
  }

  Future<List<OrderStoreProductModel>> getProductsByStoreId({String storeId, int page=1}) async{

//    TODO: Comment This
    await Future.delayed(Duration(seconds: 4));
    return [
      OrderStoreProductModel(
        id: "32333242",
        productName: "Nasi Ayam Hainan",
        description: "Ayam panggang + nasi wangi hainan",
        imagePath: PrototypeConstant.FRANCHISE_PROFILE_IMAGE,
        price: 30000,
        discountPrice: 50000
      ),
      OrderStoreProductModel(
          id: "32333242",
          productName: "Nasi Sapi Lada Hitam",
          description: "Daging sapi dengan saus lada hitam + nasi",
          imagePath: PrototypeConstant.FRANCHISE_PROFILE_IMAGE,
          price: 45000,
          discountPrice: 50000
      )
    ];
//    TODO: Uncomment This
//    final response = await _api.get(
//      url:
//      "v1/store/$storeId/product?page=$page",
//    );
//    final resDecoded = json.decode(response);
//    if(resDecoded["code"]==NetworkCode.SUCCESS){
//      return List<OrderStoreProductModel>.from(resDecoded["result"]["data"].map((x) => OrderStoreProductModel.fromJson(x)));
//    }else{
//      return [];
//    }
  }
}
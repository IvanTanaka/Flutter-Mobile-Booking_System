import 'dart:convert';

import 'package:member_apps/core/constants/network_code.dart';
import 'package:member_apps/core/models/order_store_product_model.dart';
import 'package:member_apps/core/services/api.dart';

class ProductService{

  Api _api;
  List<OrderStoreProductModel> carts;

  ProductService({Api api}){
    this._api =api;
  }

  Future<List<OrderStoreProductModel>> getProductsByStoreId({String storeId, int page=1}) async{
    final response = await _api.get(
      url:
      "v1/store/$storeId/product?page=$page",
    );
    final resDecoded = json.decode(response);
    if(resDecoded["code"]==NetworkCode.SUCCESS){
      return List<OrderStoreProductModel>.from(resDecoded["result"]["data"].map((x) => OrderStoreProductModel.fromJson(x)));
    }else{
      return [];
    }
  }
}
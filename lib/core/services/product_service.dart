import 'dart:convert';

import 'package:member_apps/core/constants/network_code.dart';
import 'package:member_apps/core/models/order_store_product_model.dart';
import 'package:member_apps/core/services/api.dart';
import 'package:member_apps/ui/prototype_constant.dart';

class ProductService{

  Api _api;
  List<OrderStoreProductModel> carts;

  ProductService({Api api}){
    this._api =api;
  }

  Future<List<OrderStoreProductModel>> getProductsByStoreId({String storeId, int page=1}) async{

//    TODO: Comment This
    await Future.delayed(Duration(seconds: 1));
    return [
      OrderStoreProductModel(
        id: "00000001",
        productName: "Nasi Ayam Hainan",
        description: "Ayam panggang + nasi wangi hainan",
        imagePath: PrototypeConstant.FRANCHISE_PROFILE_IMAGE,
        price: 30000,
        discountPrice: 50000
      ),
      OrderStoreProductModel(
          id: "00000002",
          productName: "Nasi Sapi Lada Hitam",
          description: "Daging sapi dengan saus lada hitam + nasi",
          imagePath: PrototypeConstant.FRANCHISE_PROFILE_IMAGE,
          price: 45000,
          discountPrice: 50000
      ),
      OrderStoreProductModel(
          id: "00000003",
          productName: "Nasi Ayam Bakar",
          description: "Ayam bakar + nasi putih",
          imagePath: PrototypeConstant.FRANCHISE_PROFILE_IMAGE,
          price: 30000,
          discountPrice: 50000
      ),
      OrderStoreProductModel(
          id: "00000004",
          productName: "Nasi Sapi Teriyaki",
          description: "Daging sapi dengan saus teriyaki + nasi",
          imagePath: PrototypeConstant.FRANCHISE_PROFILE_IMAGE,
          price: 45000,
          discountPrice: 50000
      ),
      OrderStoreProductModel(
          id: "00000005",
          productName: "Nasi Ayam Salted Egg",
          description: "",
          imagePath: PrototypeConstant.FRANCHISE_PROFILE_IMAGE,
          price: 30000,
          discountPrice: 50000
      ),
      OrderStoreProductModel(
          id: "00000006",
          productName: "Nasi Sapi Lada Hitam",
          description: "Daging sapi dengan saus lada hitam + nasi",
          imagePath: PrototypeConstant.FRANCHISE_PROFILE_IMAGE,
          price: 45000,
          discountPrice: 50000
      ),
      OrderStoreProductModel(
          id: "00000007",
          productName: "Nasi Ayam Hainan",
          description: "Ayam panggang + nasi wangi hainan",
          imagePath: PrototypeConstant.FRANCHISE_PROFILE_IMAGE,
          price: 30000,
          discountPrice: 50000
      ),
      OrderStoreProductModel(
          id: "00000008",
          productName: "Nasi Sapi Lada Hitam",
          description: "Daging sapi dengan saus lada hitam + nasi",
          imagePath: PrototypeConstant.FRANCHISE_PROFILE_IMAGE,
          price: 45000,
          discountPrice: 50000
      ),
      OrderStoreProductModel(
          id: "00000009",
          productName: "Nasi Ayam Hainan",
          description: "Ayam panggang + nasi wangi hainan",
          imagePath: PrototypeConstant.FRANCHISE_PROFILE_IMAGE,
          price: 30000,
          discountPrice: 50000
      ),
      OrderStoreProductModel(
          id: "00000010",
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
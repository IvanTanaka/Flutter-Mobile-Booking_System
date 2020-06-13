import 'package:member_apps/core/constants/network_config.dart';

class OrderStoreProductModel{
  String id;
  String productName;
  String description;
  String _image;
  String get imagePath {
    if(_image != null){
      String domain = NetworkConfig.DOMAIN_URL;
      return "$domain$_image";
    }return null;
  }
  int price;
//  int discountPrice;
  int qty;

  void addQty(){
    this.qty++;
  }

  void minusQty(){
    if(qty>0){
      this.qty--;
    }
  }

  void setQty(int qty){
    this.qty =qty;
  }

  OrderStoreProductModel(
      {this.id,
      this.productName,
      this.description,
      imagePath,
      this.price,
//      this.discountPrice,
      this.qty = 0}){

    if(imagePath != null){
      this._image = "storage/images/menu/$imagePath";
    }else{
      _image = null;
    }
  }

  factory OrderStoreProductModel.fromJson(Map<String, dynamic> json) =>
      OrderStoreProductModel(
        id: json["id"] == null ? null : json["id"],
        productName: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? "" : json["description"],
        imagePath: json["image_path"] == null ? null : json["image_path"],
        price: json["price"] == null ? null : json["price"],
        qty: 0,
      );
}

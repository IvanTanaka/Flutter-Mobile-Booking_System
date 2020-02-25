import 'package:member_apps/core/viewmodels/base_view_model.dart';

class OrderStoreProductModel extends BaseViewModel{
  String id;
  String productName;
  String description;
  String imagePath;
  int price;
  int discountPrice;
  int qty;

  void addQty(){
    this.qty++;
    setBusy(false);
  }

  void minusQty(){
    if(qty>0){
      this.qty--;
    }
    setBusy(false);
  }

  void setQty(int qty){
    this.qty =qty;
    setBusy(false);
  }

  OrderStoreProductModel(
      {this.id,
      this.productName,
      this.description,
      this.imagePath,
      this.price,
      this.discountPrice,
      this.qty = 0});

  factory OrderStoreProductModel.fromJson(Map<String, dynamic> json) =>
      OrderStoreProductModel(
        id: json["id"] == null ? null : json["id"],
        productName: json["product_name"] == null ? null : json["product_name"],
        description: json["description"] == null ? null : json["description"],
        imagePath: json["image_path"] == null ? null : json["image_path"],
        price: json["price"] == null ? null : json["price"],
        discountPrice:
            json["discount_price"] == null ? null : json["discount_price"],
        qty: 0,
      );
}

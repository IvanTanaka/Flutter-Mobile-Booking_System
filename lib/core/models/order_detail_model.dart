import 'package:member_apps/core/models/menu_model.dart';
import 'package:member_apps/core/services/helper.dart';

class OrderDetailModel {
  OrderDetailModel({
    this.id,
    this.orderId,
    this.menuId,
    this.price,
    this.qty,
    this.subtotal,
    this.createdAt,
    this.updatedAt,
    this.menu,
  });

  String id;
  String orderId;
  String menuId;
  int price;
  String get formattedPrice{
    return Helper.doubleToMoneyFormat(price.toDouble());
  }
  int qty;
  int subtotal;
  String get formattedSubtotal{
    return Helper.doubleToMoneyFormat(subtotal.toDouble());
  }
  DateTime createdAt;
  DateTime updatedAt;
  MenuModel menu;

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) => OrderDetailModel(
    id: json["id"] == null ? null : json["id"],
    orderId: json["order_id"] == null ? null : json["order_id"],
    menuId: json["menu_id"] == null ? null : json["menu_id"],
    price: json["price"] == null ? null : json["price"],
    qty: json["qty"] == null ? null : json["qty"],
    subtotal: json["subtotal"] == null ? null : json["subtotal"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    menu: json["menu"] == null ? null : MenuModel.fromJson(json["menu"]),
  );

}
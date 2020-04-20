import 'package:meta/meta.dart';

class OrderCartModel {
  String id;
  int qty;
  int price;

  OrderCartModel({
    @required this.id,
    @required this.qty,
    @required this.price,
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "qty": qty,
    "price": price,
  };
}

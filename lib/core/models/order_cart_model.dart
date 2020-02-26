import 'package:meta/meta.dart';

class OrderCartModel {
  String id;
  int qty;

  OrderCartModel({
    @required this.id,
    @required this.qty,
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "qty": qty,
  };
}

import 'package:member_apps/core/services/helper.dart';

class TopupModel {
  String id;
  String customerId;
  int _amount;
  String get amount => Helper.doubleToMoneyFormat(_amount.toDouble());
  String vaNumber;
  String status;
  DateTime _createdAt;
  DateTime _updatedAt;
  String get topUpDate => Helper.formatDate(_createdAt, format: "dd-MM-yyyy");
  String get topUpTime => Helper.formatDate(_createdAt, format: "hh:mm");
  String get updatedAt => Helper.formatDate(_updatedAt);

  TopupModel({
    this.id,
    this.customerId,
    int amount,
    this.vaNumber,
    this.status,
    DateTime createdAt,
    DateTime updatedAt,
  }){
    _amount = amount;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  factory TopupModel.fromJson(Map<String, dynamic> json) => TopupModel(
    id: json["id"] == null ? null : json["id"],
    customerId: json["customer_id"] == null ? null : json["customer_id"],
    amount: json["amount"] == null ? null : json["amount"],
    vaNumber: json["va_number"] == null ? null : json["va_number"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

}

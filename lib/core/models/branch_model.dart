import 'package:member_apps/core/models/franchise_model.dart';

class BranchModel {
  String id;
  String franchiseId;
  String name;
  String address;
  String phoneNumber;
  String openTime;
  String closeTime;
  FranchiseModel franchise;

  String get franchiseName {
    if(this.franchise.name == this.name){
      return this.name;
    }
    return "${this.franchise.name} - ${this.name}";
  }
  int get openHour => int.parse(openTime.substring(0,2));
  int get openMinute => int.parse(openTime.substring(3,5));
  int get closeHour => int.parse(closeTime.substring(0,2));
  int get closeMinute => int.parse(closeTime.substring(3,5));

  BranchModel({
    this.id,
    this.franchiseId,
    this.name,
    this.address,
    this.phoneNumber,
    this.openTime,
    this.closeTime,
    this.franchise,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) => BranchModel(
    id: json["id"] == null ? null : json["id"],
    franchiseId: json["franchise_id"] == null ? null : json["franchise_id"],
    name: json["name"] == null ? null : json["name"],
    address: json["address"] == null ? null : json["address"],
    phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
    openTime: json["open_time"] == null ? null : json["open_time"],
    closeTime: json["close_time"] == null ? null : json["close_time"],
    franchise: json["franchise"] == null ? null : FranchiseModel.fromJson(json["franchise"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "franchise_id": franchiseId == null ? null : franchiseId,
    "name": name == null ? null : name,
    "address": address == null ? null : address,
    "phone_number": phoneNumber == null ? null : phoneNumber,
    "open_time": openTime == null ? null : openTime,
    "close_time": closeTime == null ? null : closeTime,
    "franchise": franchise == null ? null : franchise.toJson(),
  };
}

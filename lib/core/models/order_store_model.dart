import 'package:member_apps/core/constants/booking_service_const.dart';
import 'package:member_apps/core/enumerations/booking_service_type.dart';

class OrderStoreModel {
  String id;
  String franchiseName;
  String branchName;
  String address;
  String phoneNumber;
  String _type;

  // ignore: missing_return
  BookingServiceType get type {
    switch (_type) {
      case BookingServiceConst.KARAOKE:
        return BookingServiceType.karaoke;
      case BookingServiceConst.FOOD:
        return BookingServiceType.food;
      case BookingServiceConst.SPORT:
        return BookingServiceType.sport;
      case BookingServiceConst.BARBER:
        return BookingServiceType.barber;
    }
  }

  OrderStoreModel(
      {this.id,
      this.franchiseName,
      this.branchName,
      this.address,
      this.phoneNumber,
      String type}) {
    this._type = type;
  }

  factory OrderStoreModel.fromJson(Map<String, dynamic> json) =>
      OrderStoreModel(
        id: json["id"] == null ? null : json["id"],
        franchiseName:
            json["franchise_name"] == null ? null : json["franchise_name"],
        type: json["type"] == null ? null : json["type"],
        branchName: json["branch_name"] == null ? null : json["branch_name"],
      );
}

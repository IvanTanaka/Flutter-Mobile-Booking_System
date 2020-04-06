import 'package:member_apps/core/constants/booking_service_const.dart';
import 'package:member_apps/core/enumerations/booking_service_type.dart';
import 'package:member_apps/core/models/branch_model.dart';

class SearchStoreModel {
  String id;
  String franchiseName;
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

  List<BranchModel> branches;

  bool get haveBranches {
    if (branches.length > 1) {
      return true;
    }
    return false;
  }

  String get branchId {
    if (!haveBranches) {
      return branches[0].id;
    }
    return "";
  }

  String get address {
    if (!haveBranches) {
      return branches[0].address;
    }
    return "";
  }

  String get phoneNumber {
    if (!haveBranches) {
      return branches[0].phoneNumber;
    }
    return "";
  }

  SearchStoreModel({this.id, this.franchiseName, this.branches, String type}) {
    this._type = type;
  }

  factory SearchStoreModel.fromJson(Map<String, dynamic> json) =>
      SearchStoreModel(
        id: json["id"] == null ? null : json["id"],
        franchiseName:
            json["name"] == null ? null : json["name"],
        type: json["type"] == null ? null : json["type"],
        branches: json["branches"] == null
            ? null
            : List<BranchModel>.from(
                json["branches"].map((x) => BranchModel.fromJson(x))),
      );
}

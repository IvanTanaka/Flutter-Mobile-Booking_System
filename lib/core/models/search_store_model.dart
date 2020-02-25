import 'package:member_apps/core/models/branch_model.dart';

class SearchStoreModel {
  String id;
  String franchiseName;
  String type;
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

  SearchStoreModel({
    this.id,
    this.franchiseName,
    this.type,
    this.branches,
  });

  factory SearchStoreModel.fromJson(Map<String, dynamic> json) =>
      SearchStoreModel(
        id: json["id"] == null ? null : json["id"],
        franchiseName:
            json["franchise_name"] == null ? null : json["franchise_name"],
        type: json["type"] == null ? null : json["type"],
        branches: json["branchs"] == null
            ? null
            : List<BranchModel>.from(
                json["branchs"].map((x) => BranchModel.fromJson(x))),
      );
}

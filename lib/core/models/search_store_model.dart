import 'package:member_apps/core/models/branch_model.dart';

class SearchStoreModel {
  String id;
  String franchiseName;
  String ratingStars;


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

  SearchStoreModel({this.id, this.franchiseName,this.ratingStars, this.branches});

  factory SearchStoreModel.fromJson(Map<String, dynamic> json) =>
      SearchStoreModel(
        id: json["id"] == null ? null : json["id"],
        franchiseName:
            json["name"] == null ? null : json["name"],
        ratingStars:
            json["rating_stars"] == null ? null : json["rating_stars"],
        branches: json["branches"] == null
            ? null
            : List<BranchModel>.from(
                json["branches"].map((x) => BranchModel.fromJson(x))),
      );
}

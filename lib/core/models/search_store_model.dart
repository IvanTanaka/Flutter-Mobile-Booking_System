import 'package:member_apps/core/models/branch_model.dart';

class SearchStoreModel {
  String id;
  String franchiseName;
  List<BranchModel> branchs;

  SearchStoreModel({
    this.id,
    this.franchiseName,
    this.branchs,
  });

  factory SearchStoreModel.fromJson(Map<String, dynamic> json) => SearchStoreModel(
    id: json["id"],
    franchiseName: json["franchise_name"],
    branchs: List<BranchModel>.from(json["branchs"].map((x) => BranchModel.fromJson(x))),
  );

}

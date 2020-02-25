import 'package:member_apps/core/models/branch_model.dart';

class NewsDetailModel {
  String id;
  String franchiseName;
  String imageUrl;
  String description;
  List<String> termsAndConditions;
  List<BranchModel> branches;

  NewsDetailModel({
    this.id,
    this.franchiseName,
    this.imageUrl,
    this.description,
    this.termsAndConditions,
    this.branches,
  });

  factory NewsDetailModel.fromJson(Map<String, dynamic> json) =>
      NewsDetailModel(
        id: json["id"] == null ? null : json["id"],
        franchiseName:
            json["franchise_name"] == null ? null : json["franchise_name"],
        imageUrl: json["image_url"] == null ? null : json["image_url"],
        description: json["description"] == null ? null : json["description"],
        termsAndConditions: json["terms_and_conditions"] == null
            ? null
            : List<String>.from(json["terms_and_conditions"].map((x) => x)),
        branches: json["branchs"] == null
            ? null
            : List<BranchModel>.from(
                json["branchs"].map((x) => BranchModel.fromJson(x))),
      );
}

import 'package:member_apps/core/models/branch_model.dart';

class NewsDetailModel {
  String id;
  String franchiseName;
  String imageUrl;
  String description;
  List<String> termsAndConditions;
  List<BranchModel> branchs;

  NewsDetailModel({
    this.id,
    this.franchiseName,
    this.imageUrl,
    this.description,
    this.termsAndConditions,
    this.branchs,
  });

  factory NewsDetailModel.fromJson(Map<String, dynamic> json) => NewsDetailModel(
    id: json["id"],
    franchiseName: json["franchise_name"],
    imageUrl: json["image_url"],
    description: json["description"],
    termsAndConditions: List<String>.from(json["terms_and_conditions"].map((x) => x)),
    branchs: List<BranchModel>.from(json["branchs"].map((x) => BranchModel.fromJson(x))),
  );
}
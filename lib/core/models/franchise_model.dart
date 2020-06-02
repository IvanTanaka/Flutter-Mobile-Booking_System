import 'package:member_apps/ui/prototype_constant.dart';

class FranchiseModel {
  String id;
  String ownerId;
  String categoryId;
  String name;
  String imagePath;

  FranchiseModel({
    this.id,
    this.ownerId,
    this.categoryId,
    this.name,
    this.imagePath,
  });

  factory FranchiseModel.fromJson(Map<String, dynamic> json) => FranchiseModel(
    id: json["id"] == null ? null : json["id"],
    ownerId: json["owner_id"] == null ? null : json["owner_id"],
    categoryId: json["category_id"] == null ? null : json["category_id"],
    name: json["name"] == null ? null : json["name"],
    imagePath: json["image_path"] == null? PrototypeConstant.FRANCHISE_PROFILE_IMAGE:json["image_path"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "owner_id": ownerId == null ? null : ownerId,
    "category_id": categoryId,
    "name": name == null ? null : name,
    "image_path": imagePath,
  };
}
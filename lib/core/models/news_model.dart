import 'package:member_apps/core/constants/network_config.dart';
import 'package:member_apps/core/models/franchise_model.dart';

class NewsModel {
  String id;
  String franchiseId;
  String _image;
  String get imagePath {
    String domain = NetworkConfig.DOMAIN_URL;
    print("$domain$_image");
    return "$domain$_image";
  }
  String description;
  DateTime createdAt;
  DateTime updatedAt;
  FranchiseModel franchise;

  NewsModel({
    this.id,
    this.franchiseId,
    imagePath,
    this.description,
    this.franchise,
  }){

    this._image = "storage/images/news/$imagePath";
  }

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
    id: json["id"] == null ? null : json["id"],
    franchiseId: json["franchise_id"] == null ? null : json["franchise_id"],
    imagePath: json["image_path"] == null ? null : json["image_path"],
    description: json["description"] == null ? null : json["description"],
    franchise: json["franchise"] == null ? null : FranchiseModel.fromJson(json["franchise"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "franchise_id": franchiseId == null ? null : franchiseId,
    "image_path": imagePath == null ? null : imagePath,
    "description": description == null ? null : description,
    "franchise": franchise == null ? null : franchise.toJson(),
  };
}

import 'package:member_apps/core/constants/network_config.dart';
import 'package:member_apps/core/models/branch_model.dart';
import 'package:member_apps/core/models/franchise_model.dart';

class NewsDetailModel {
  String id;
  String franchiseId;
  String _image;
  String get imagePath {
    String domain = NetworkConfig.DOMAIN_URL;
    return "$domain$_image";
  }
  FranchiseModel franchise;
  String description;
  List<BranchModel> branches;

  NewsDetailModel({
    this.id,
    this.franchiseId,
    imagePath,
    this.description,
    this.franchise,
    this.branches,
  }){

    this._image = "storage/images/news/$imagePath";
  }

  factory NewsDetailModel.fromJson(Map<String, dynamic> json) =>
      NewsDetailModel(
        id: json["id"] == null ? null : json["id"],
        franchiseId: json["franchise_id"] == null ? null : json["franchise_id"],
        imagePath: json["image_path"] == null ? null : json["image_path"],
        description: json["description"] == null ? null : json["description"],
        franchise: json["franchise"] == null ? null : FranchiseModel.fromJson(json["franchise"]),
        branches: json["branches"] == null
            ? null
            : List<BranchModel>.from(
                json["branches"].map((x) => BranchModel.fromJson(x))),
      );
}

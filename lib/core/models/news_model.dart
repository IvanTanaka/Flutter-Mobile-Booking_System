class NewsModel {
  String id;
  String franchiseName;
  String imageUrl;
  String description;

  NewsModel({
    this.id,
    this.franchiseName,
    this.imageUrl,
    this.description,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        id: json["id"] == null ? null : json["id"],
        franchiseName:
            json["franchise_name"] == null ? null : json["franchise_name"],
        imageUrl: json["image_url"] == null ? null : json["image_url"],
        description: json["description"] == null ? null : json["description"],
      );
}

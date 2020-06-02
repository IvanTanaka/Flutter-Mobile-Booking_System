class MenuModel {
  MenuModel({
    this.id,
    this.franchiseId,
    this.name,
    this.description,
    this.imagePath,
    this.price,
    this.createdAt,
    this.updatedAt,
  });

  String id;
  String franchiseId;
  String name;
  dynamic description;
  String imagePath;
  int price;
  DateTime createdAt;
  DateTime updatedAt;

  factory MenuModel.fromJson(Map<String, dynamic> json) => MenuModel(
    id: json["id"] == null ? null : json["id"],
    franchiseId: json["franchise_id"] == null ? null : json["franchise_id"],
    name: json["name"] == null ? null : json["name"],
    description: json["description"],
    imagePath: json["image_path"] == null ? null : json["image_path"],
    price: json["price"] == null ? null : json["price"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "franchise_id": franchiseId == null ? null : franchiseId,
    "name": name == null ? null : name,
    "description": description,
    "image_path": imagePath == null ? null : imagePath,
    "price": price == null ? null : price,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
  };
}

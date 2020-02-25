class OrderStoreMenuModel {
  String id;
  String menuName;
  String description;
  String imagePath;
  int price;
  int discountPrice;
  int qty;

  OrderStoreMenuModel(
      {this.id,
      this.menuName,
      this.description,
      this.imagePath,
      this.price,
      this.discountPrice,
      this.qty = 0});

  factory OrderStoreMenuModel.fromJson(Map<String, dynamic> json) =>
      OrderStoreMenuModel(
        id: json["id"] == null ? null : json["id"],
        menuName: json["menu_name"] == null ? null : json["menu_name"],
        description: json["description"] == null ? null : json["description"],
        imagePath: json["image_path"] == null ? null : json["image_path"],
        price: json["price"] == null ? null : json["price"],
        discountPrice:
            json["discount_price"] == null ? null : json["discount_price"],
        qty: 0,
      );
}

class RateModel {
  RateModel({
    this.id,
    this.orderId,
    this.customerId,
    this.branchId,
    this.stars,
    this.comment,
  });

  String id;
  String orderId;
  String customerId;
  String branchId;
  int stars;
  String comment;

  factory RateModel.fromJson(Map<String, dynamic> json) => RateModel(
    id: json["id"],
    orderId: json["order_id"],
    customerId: json["customer_id"],
    branchId: json["branch_id"],
    stars: json["stars"],
    comment: json["comment"] == null? "":json["comment"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "customer_id": customerId,
    "branch_id": branchId,
    "stars": stars,
    "comment": comment,
  };
}

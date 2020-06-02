class CashierModel{

  String id;
  String ownerId;
  String branchId;
  String name;

  CashierModel({
    this.id,
    this.ownerId,
    this.branchId,
    this.name,
  });

  factory CashierModel.fromJson(Map<String, dynamic> json) => CashierModel(
    id: json["id"] == null ? null : json["id"],
    ownerId: json["owner_id"] == null ? null : json["owner_id"],
    branchId: json["branchId"] == null ? null : json["branchId"],
    name: json["name"] == null ? null : json["name"],
  );

}
class BranchModel {
  String id;
  String branchName;
  String address;
  String phoneNumber;

  BranchModel({
    this.id,
    this.branchName,
    this.address,
    this.phoneNumber,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) => BranchModel(
        id: json["id"] == null ? null : json["id"],
        branchName: json["name"] == null ? null : json["name"],
        address: json["address"] == null ? null : json["address"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
      );
}

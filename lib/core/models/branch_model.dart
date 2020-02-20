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
    id: json["id"],
    branchName: json["branch_name"],
    address: json["address"],
    phoneNumber: json["phone_number"],
  );

}
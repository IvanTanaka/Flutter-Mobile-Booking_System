class BranchModel {
  String branchName;
  String address;
  String phoneNumber;

  BranchModel({
    this.branchName,
    this.address,
    this.phoneNumber,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) => BranchModel(
    branchName: json["branch_name"],
    address: json["address"],
    phoneNumber: json["phone_number"],
  );

}
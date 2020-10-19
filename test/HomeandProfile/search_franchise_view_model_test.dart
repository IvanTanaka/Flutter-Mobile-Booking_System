import 'package:member_apps/core/models/branch_model.dart';
import 'package:member_apps/core/models/search_store_model.dart';
import 'package:member_apps/core/services/store_service.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockClient extends Mock implements StoreService {}

void main() {
  final client = MockClient();
  final branchModel = BranchModel();
  String name = "FoodAW";
  String foodCategory = "Chicken";
  var searchStoreModelJson = {
    "id": "123123",
    "franchiseName": "FoodAW",
    "ratingStar": "5.0",
    "branches": [branchModel.toJson()]
  };
  List<SearchStoreModel> listSearchStoreModel = [
    SearchStoreModel.fromJson(searchStoreModelJson)
  ];
  test("testing getStoresByFilter function, expected return as dummy",
      () async {
    when(client.getStoresByFilter(name: name, foodCategory: foodCategory))
        .thenAnswer((_) async => listSearchStoreModel);
    var result =
        await client.getStoresByFilter(name: name, foodCategory: foodCategory);
    expect(result[0].id, listSearchStoreModel[0].id);
  });

  test("testing getStoresByFilter function, expected return error", () async {
    when(client.getStoresByFilter(name: name, foodCategory: foodCategory))
        .thenAnswer((_) async => listSearchStoreModel);
    var result = await client.getStoresByFilter(name: name, foodCategory: null);
    AssertionError(result);
  });
}

import 'package:member_apps/core/models/topup_model.dart';
import 'package:member_apps/core/services/topup_service.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockClient extends Mock implements TopupService {}

void main() {
  final client = MockClient();
  var page = 0;
  var topUpJson = {
    "id": "123123",
    "customerId": "asdasdq23",
    "amount": 100000000,
    "vaNumber": "1111111",
    "status": "test",
    "createdAt": "12-12-1999",
    "updatedAt": "12-12-2000"
  };
  List<TopupModel> listTopUpModel = [TopupModel.fromJson(topUpJson)];

  test("load topup history , expected same as dummy", () async {
    when(client.loadHistories(page: page))
        .thenAnswer((_) async => listTopUpModel);
    var result = await client.loadHistories(page: page);
    expect(result[0].id, listTopUpModel[0].id);
  });

  test("load topup history , expected error", () async {
    when(client.loadHistories(page: page))
        .thenAnswer((_) async => listTopUpModel);
    var result = await client.loadHistories(page: null);
    AssertionError(result);
  });
}

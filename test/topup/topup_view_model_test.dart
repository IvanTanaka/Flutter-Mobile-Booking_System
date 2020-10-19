import 'package:member_apps/core/models/topup_model.dart';
import 'package:member_apps/core/services/topup_service.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockClient extends Mock implements TopupService {}

void main() {
  final client = MockClient();
  var amount = 1000000;
  var topUpJson = {
    "id": "123123",
    "customerId": "asdasdq23",
    "amount": amount,
    "vaNumber": "1111111",
    "status": "test",
    "createdAt": "12-12-1999",
    "updatedAt": "12-12-2000"
  };
  TopupModel topUpModel = TopupModel.fromJson(topUpJson);

  test("testing top up method", () async {
    when(client.topUp(amount: amount)).thenAnswer((_) async => topUpModel);
    var result = await client.topUp(amount: amount);
    expect(result.amount, topUpModel.amount);
  });

  test('testing top up method using no amount, expected error', () async {
    when(client.topUp(amount: amount)).thenAnswer((_) async => topUpModel);
    var result = await client.topUp(amount: null);
    expect(result, isNull);
  });
}

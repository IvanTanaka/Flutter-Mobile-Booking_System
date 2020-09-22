import 'package:member_apps/core/models/topup_model.dart';
import 'package:member_apps/core/services/topup_service.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockClient extends Mock implements TopupService {}

void main() {
  final client = MockClient();
  var topup = {
    "id": "123123",
    "customerId": "asdasdq23",
    "amount": 1000000,
    "vaNumber": "1111111",
    "status": "test",
    "createdAt": "12-12-1999",
    "updatedAt": "12-12-2000"
  };
  List<TopupModel> tpup = [TopupModel.fromJson(topup)];
  test('testing top up method on topup home view model', () async {
    when(client.loadHistories()).thenAnswer((_) async => tpup);
    var result = await client.loadHistories();
    expect(result[0].amount, tpup[0].amount);
  });
}

import 'package:member_apps/core/models/topup_model.dart';
import 'package:member_apps/core/services/topup_service.dart';
import 'package:member_apps/core/services/wallet_service.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockClient extends Mock implements TopupService, WalletService {}

void main() {
  final client = MockClient();
  var dummyId = "123";
  String walletMoney = "Rp. 300.000,00";
  var walletJson = {
    "id": "123",
    "customerId": "123aaa",
    "amount": 300000,
    "vaNumber": "123456",
    "status": "running"
  };
  TopupModel topupModel = TopupModel.fromJson(walletJson);
  List<TopupModel> listTopUpModel = [TopupModel.fromJson(walletJson)];
  test("testing load top up function , expected return topup model ", () async {
    when(client.loadTopUp(id: dummyId)).thenAnswer((_) async => topupModel);
    var result = await client.loadTopUp(id: dummyId);
    expect(result.id, topupModel.id);
  });

  test("testing load top up function , expected return error ", () async {
    when(client.loadTopUp(id: dummyId)).thenAnswer((_) async => topupModel);
    var result = await client.loadTopUp(id: null);
    AssertionError(result);
  });

  test("testing loadtopup function, expected return topupmodel and wallet",
      () async {
    when(client.loadWallet()).thenAnswer((_) async => walletMoney);
    when(client.loadHistories()).thenAnswer((_) async => listTopUpModel);
    var result1 = await client.loadWallet();
    var result2 = await client.loadHistories();
    expect(result1, walletMoney);
    expect(result2[0].id, listTopUpModel[0].id);
  });
}

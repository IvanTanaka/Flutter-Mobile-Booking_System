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
  var wallet = {
    "id": "123",
    "customerId": "123aaa",
    "amount": 300000,
    "vaNumber": "123456",
    "status": "running"
  };
  TopupModel wm = TopupModel.fromJson(wallet);
  List<TopupModel> lWm = [TopupModel.fromJson(wallet)];
  test("testing load top up function , expected return topup model ", () async {
    when(client.loadTopUp(id: dummyId)).thenAnswer((_) async => wm);
    var result = await client.loadTopUp(id: dummyId);
    expect(result.id, wm.id);
  });
  test("testing loadtopup function, expected return topupmodel and wallet",
      () async {
    when(client.loadWallet()).thenAnswer((_) async => walletMoney);
    when(client.loadHistories()).thenAnswer((_) async => lWm);
    var result1 = await client.loadWallet();
    var result2 = await client.loadHistories();
    expect(result1, walletMoney);
    expect(result2[0].id, lWm[0].id);
  });
}

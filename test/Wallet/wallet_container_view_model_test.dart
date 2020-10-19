import 'package:member_apps/core/services/wallet_service.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockClient extends Mock implements WalletService {}

void main() {
  final client = MockClient();
  String walletMoney = "Rp. 300.000,00";
  test("testing Load Wallet function, expected return as dummy", () async {
    when(client.loadWallet()).thenAnswer((_) async => walletMoney);
    var result = await client.loadWallet();
    expect(result, walletMoney);
  });
}

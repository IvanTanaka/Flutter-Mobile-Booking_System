import 'package:member_apps/core/models/branch_model.dart';
import 'package:member_apps/core/models/cashier_model.dart';
import 'package:member_apps/core/models/menu_model.dart';
import 'package:member_apps/core/models/order_detail_model.dart';
import 'package:member_apps/core/models/order_model.dart';
import 'package:member_apps/core/models/rate_model.dart';
import 'package:member_apps/core/services/order_service.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockClient extends Mock implements OrderService {}

void main() {
  final client = MockClient();
  final branchModel = BranchModel();
  final menuModel = MenuModel();
  final rateModel = RateModel();
  var cashierModelJson = {
    "id": "id01",
    "ownerId": "ownerId01",
    "branchId": "branchId01",
    "name": "cashierzeroone"
  };
  // var menuJson = {
  //   "id": "menu01",
  //   "franchiseId": "franchise01",
  //   "name": "menusatu",
  //   "description": "deskripsi",
  //   "imagePath": "dummyImage",
  //   "price": 30000
  // };
  var orderDetailJson = {
    "id": "orderDetailId01",
    "orderId": "orderId01",
    "menuId": "menuId01",
    "price": 30000,
    "qty": 10,
    "subtotal": 300000,
    "menu": menuModel.toJson()
  };
  var orderJson = {
    "id": "id001",
    "orderCode": "Order01",
    "customerId": "custId01",
    "branchId": "branchId01",
    "cashierId": "cashierId01",
    "franchiseId": "frnachiseId01",
    "status": "Accepted",
    "total": 3000000,
    "peopleCount": 3,
    "note": "testNote",
    "orderDetails": [OrderDetailModel.fromJson(orderDetailJson)],
    "branch": branchModel.toJson(),
    "cashierModel": CashierModel.fromJson(cashierModelJson),
    "rate": rateModel.toJson()
  };

  List<OrderModel> listOrderModel = [OrderModel.fromJson(orderJson)];

  test("testing load history function, expected as dummy", () async {
    when(client.loadOrders()).thenAnswer((_) async => listOrderModel);
    var result = await client.loadOrders();
    expect(result[0].id, listOrderModel[0].id);
  });
}

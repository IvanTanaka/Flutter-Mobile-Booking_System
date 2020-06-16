import 'package:member_apps/core/enumerations/order_food_type.dart';
import 'package:member_apps/core/models/branch_model.dart';
import 'package:member_apps/core/models/order_cart_model.dart';
import 'package:member_apps/core/models/order_store_product_model.dart';
import 'package:member_apps/core/services/helper.dart';
import 'package:member_apps/core/services/order_service.dart';
import 'package:member_apps/core/services/product_service.dart';
import 'package:member_apps/core/services/store_service.dart';
import 'package:member_apps/core/services/wallet_service.dart';
import 'package:member_apps/core/viewmodels/base_view_model.dart';

class OrderFoodConfirmationViewModel extends BaseViewModel {
  OrderService _orderService;
  ProductService _productService;
  StoreService _storeService;
  WalletService _walletService;
  int get walletAmount => _walletService.walletAmount;

  BranchModel get branchModel => _storeService.branchModel;
  String orderId;

  OrderFoodConfirmationViewModel(
      {StoreService storeService,
      OrderService orderService,
      ProductService productService,
      WalletService walletService}) {
    this._storeService = storeService;
    this._orderService = orderService;
    this._productService = productService;
    this._walletService = walletService;
  }



  int _dineInQty = 1;

  int get dineInQty {
    return (orderFoodType == OrderFoodType.takeAway) ? 0 : _dineInQty;
  }

  set dineInQty(int _qty) {
    if (_qty < 1) {
      _qty = 1;
    }
    _dineInQty = _qty;
    setBusy(false);
  }

  OrderFoodType _orderFoodType = OrderFoodType.takeAway;

  OrderFoodType get orderFoodType => this._orderFoodType;

  set orderFoodType(OrderFoodType _type) {
    _orderFoodType = _type;
    setBusy(false);
  }

  List<OrderCartModel> get carts => _orderService.carts;

  DateTime get orderDate => _orderService.orderDate;

  DateTime get minOrderDate => DateTime.now().add(Duration(minutes: 15));

  DateTime get maxOrderDate => DateTime.now().add(Duration(days: 7));

  set orderDate(DateTime dateTime) {
    _orderService.orderDate = dateTime;
    notifyListeners();
  }

  String get orderDateString =>
      Helper.formatDate(orderDate, format: "EEEE, dd MMM yy");

  String get orderTimeString => Helper.formatDate(orderDate, format: "HH:mm");

  List<OrderStoreProductModel> get orderDetail => _productService.carts;

  int get subtotalOrderPrice {
    int subtotalPrice = 0;
    orderDetail.forEach((OrderStoreProductModel model) {
      subtotalPrice += (model.qty * model.price);
    });
    return subtotalPrice;
  }

//  int get taxOrderPrice => (subtotalOrderPrice*0.1).ceil();
  int get taxOrderPrice => 0;

  int get totalOrderPrice => (subtotalOrderPrice + taxOrderPrice);

  void refreshCarts(OrderStoreProductModel model) {
    orderDetail.removeWhere((OrderStoreProductModel storeProductModel) {
      if (storeProductModel.id == model.id) {
        storeProductModel.qty = model.qty;
      }
      return storeProductModel.id == model.id && model.qty <= 0;
    });
    carts.where((OrderCartModel cartModel) {
      if (cartModel.id == model.id) {
        cartModel.qty = model.qty;
      }
      return cartModel.id == model.id && model.qty <= 0;
    });
    setBusy(false);
  }

  Future<void> submitOrder({String storeId}) async {
    setBusy(true);
    orderId = await _orderService.submitOrder(
        storeId: storeId,
        total: totalOrderPrice,
        dineInQty: dineInQty,
        orderDate: orderDate);
    setBusy(false);
  }
}

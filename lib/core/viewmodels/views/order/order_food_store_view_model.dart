import 'package:member_apps/core/models/branch_model.dart';
import 'package:member_apps/core/models/order_cart_model.dart';
import 'package:member_apps/core/models/order_store_product_model.dart';
import 'package:member_apps/core/services/order_service.dart';
import 'package:member_apps/core/services/product_service.dart';
import 'package:member_apps/core/services/store_service.dart';
import 'package:member_apps/core/viewmodels/base_view_model.dart';

class OrderFoodStoreViewModel extends BaseViewModel {
  StoreService _storeService;
  ProductService _productService;
  OrderService _orderService;
  BranchModel get branchModel => _storeService.branchModel;

  OrderFoodStoreViewModel({StoreService storeService, ProductService productService, OrderService orderService}) {
    this._storeService = storeService;
    this._productService = productService;
    this._orderService = orderService;

    page = 0;
  }

  List<OrderStoreProductModel> orderStoreProducts = [];
  List<OrderStoreProductModel> cartsProducts =[];
  List<OrderCartModel> carts = [];
  int page = 0;

  DateTime _orderDate;
  DateTime get orderDate => _orderDate;
  DateTime get minOrderDate => DateTime.now().add(Duration(minutes: 15));
  DateTime get maxOrderDate => DateTime.now().add(Duration(days: 7));

  set orderDate(DateTime dateTime) {
    _orderService.orderDate = dateTime;
    _orderDate = dateTime;
    notifyListeners();
  }

  Future<void> loadStore({String storeId}) async {
    setBusy(true);
    await _storeService.getBranchByStoreId(storeId);
    setBusy(false);
  }

  Future getProducts({String storeId}) async {
    setBusy(true);
    page++;
    List<OrderStoreProductModel> tempModels = await _productService.getProductsByStoreId(
      storeId: storeId
    );
    orderStoreProducts.addAll(tempModels);
    setBusy(false);
  }

  void refreshCarts(OrderStoreProductModel model){
    cartsProducts.removeWhere((OrderStoreProductModel cartModel){
      return cartModel.id == model.id;
    });
    if(model.qty>0){
      cartsProducts.add(model);
    }
    carts.removeWhere((OrderCartModel cartModel){
      return cartModel.id == model.id;
    });
    if(model.qty>0){
      carts.add(OrderCartModel(id: model.id, qty: model.qty, price: model.price));
    }
    setBusy(false);
  }

  void continueOrder(){
    _orderService.carts = carts;
    _productService.carts = cartsProducts;
    setBusy(false);
  }
}

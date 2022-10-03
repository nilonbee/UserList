import 'package:flutter/cupertino.dart';
import 'package:shopping_list_app/repo/api_call.dart';

import '../models/product_model.dart';

class ProductViewModal extends ChangeNotifier{

  var productList = <ProductModal>[];
  var cartList = <ProductModal>[];
  var isLoading = true;
  int get countCart => cartList.length;
  double get totalPrice => cartList.fold(0, (preValue, element) => preValue + element.price!);

  setLoading (bool loading){
    isLoading = loading;
    notifyListeners();
  }

  Future <void>getAllProducts() async{
    var product = await ProductRepository.fetchAllProducts();
    if (product != null) {
      productList = product;
      setLoading(false);
    }
  }

  addToCart (ProductModal item) {
    cartList.add(item);
    notifyListeners();
  }

  removeFromCart (ProductModal item) {
    cartList.remove(item);
    notifyListeners();
  }

  clearCart() {
  cartList.clear();
  }
}
import 'package:flutter/material.dart';
import '../entities/cart_info.dart';

class CartInfoViewModel extends ChangeNotifier {
  List<CartInfo> _cartInfoList = [];

  addToCart(CartInfo newItem){
    int pos = _posIfItemAlreadyExist(newItem.id!);
    if(pos != -1){
      _cartInfoList[pos].qty = newItem.qty;
    } else {
      _cartInfoList.add(newItem);
    }
    notifyListeners();
  }

  deleteFromCart(int id){
    int pos = _posIfItemAlreadyExist(id);
    if(pos != -1){
      _cartInfoList.removeAt(pos);
    }
    notifyListeners();
  }

  editItemQuantity(int id, int qty){
    int pos = _posIfItemAlreadyExist(id);
    if(pos != -1){
      _cartInfoList[pos].qty = qty;
    }
    notifyListeners();
  }

  double calculateTotal(){
    double total = 0.0;
    if(_cartInfoList.isNotEmpty){
      for(var item in _cartInfoList){
        final price = item.price ?? 0.0;
        final qty = item.qty??0;
        total += (qty * price);
      }
    }
    return total;
  }

  int getSelectedQty(int id){
    int pos = _posIfItemAlreadyExist(id);
    int qty = 1;
    if(pos != -1){
      qty = _cartInfoList[pos].qty ?? 1;
    }
    return qty;
  }

  int _posIfItemAlreadyExist(int itemId){
    int itemPos = -1;
    for (var pos = 0; pos < _cartInfoList.length; pos++) {
      if(itemId == _cartInfoList[pos].id){
        itemPos = pos;
      }
    }
    return itemPos;
  }

  List<CartInfo> get cartInfoList => _cartInfoList;
}
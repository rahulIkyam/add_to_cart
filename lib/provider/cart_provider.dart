import 'package:flutter/cupertino.dart';

class AddToCartProvider with ChangeNotifier{

  final Map<int, int> _cartItems = {};
  Map<int, int> get cartItems => _cartItems;

  void addItem(int index){
    if(_cartItems.containsKey(index)){
      _cartItems[index] = _cartItems[index]! + 1;
      print('----- add item ------');
      print(_cartItems[index]);
    }else{
      _cartItems[index] = 1;
    }
    notifyListeners();
  }

  void removeItem(int index){
    if(_cartItems.containsKey(index) && _cartItems[index]! > 1){
      _cartItems[index] = _cartItems[index]! -1;
      print('----- remove item ------');
      print(_cartItems[index]);
    }else{
      _cartItems.remove(index);
    }
    notifyListeners();
  }

  int get totalItems{
    int total = 0;
    _cartItems.forEach((key, value) {
      total += value;
    });
    return total;
  }
}

Map item ={

  "item 1" : 3,
  "item 2" : 2,
};
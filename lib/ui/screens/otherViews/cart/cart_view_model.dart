

import 'package:flutter/material.dart';
import 'package:movie_mart/core/services/firestoreServices.dart';
import 'package:movie_mart/utils/baseModel/baseModel.dart';
import 'package:movie_mart/utils/constants/locator.dart';
import 'package:movie_mart/utils/router/navigationService.dart';
import 'package:movie_mart/utils/router/routeNames.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartViewModel extends BaseModel {
  final FireStoreService _firestoreService = locator<FireStoreService>();
  final NavigationService _navigationService = locator<NavigationService>();
  int prc = 0;
  int get price => prc;


  set price (int value){
    prc = value;
    notifyListeners();
    print(value.toString());
  }

  getCart() {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    //   String userId  = prefs.getString('userIdentity');
     return _firestoreService.getCartItems();
  }

  deleteItem(var data){
    _firestoreService.deleteFromCart(data);
    print('deleted');
    return  removeItem();
  }

  void animatedRemoveFromList(GlobalKey<AnimatedListState> _listKey, AsyncSnapshot<dynamic> snapshot ,String title, Widget child) {
      final index = snapshot.data.docs.indexWhere((u) => u["title"] == title);
      var user = snapshot.data.docs.removeAt(index);
      _listKey.currentState.removeItem(
        index,
        (context, animation) {
          return FadeTransition(
            opacity: CurvedAnimation(
                parent: animation, curve: const Interval(0.5, 1.0)),
            child: SizeTransition(
              sizeFactor: CurvedAnimation(
                  parent: animation, curve: const Interval(0.0, 1.0)),
              axisAlignment: 0.0,
              child: child,
            ),
          );
        },
        duration: const Duration(milliseconds: 600),
      );
      notifyListeners();
  }

  increaseQuantiyPrice(String documentId, int newQuantity, int newPrice){
    return _firestoreService.updateItemQuantity(documentId, newQuantity, newPrice);
  }
  
  navigateToHome(){
   return _navigationService.navigateReplacementTo(HomePageRoute);
  }

  pop(){
    return _navigationService.pop();
  }

}
import 'dart:js';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_mart/core/services/firestoreServices.dart';
import 'package:movie_mart/utils/constants/helpers.dart';
import 'package:movie_mart/utils/constants/locator.dart';
import 'package:movie_mart/utils/dialogeManager/dialogModels.dart';
import 'package:movie_mart/utils/dialogeManager/dialogService.dart';

enum AppState{idle, loading, error}

class BaseModel extends ChangeNotifier {
  final ProgressService _progressService = locator<ProgressService>();
  final FireStoreService _fireStoreService = locator<FireStoreService>();
  ProgressResponse response;
  AppState state = AppState.idle;
  int cartValue = 0;
  int get cartVl => cartValue;

  bool _busy = false;
  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
    if(value == true){
      _progressService.loadingDialog();
    }else
    {
      _progressService.dialogComplete(response);
    }
  }

  void setCartValue(){
    cartValue = cartValue++;
    notifyListeners();
  }

  void removeItem(){
    cartValue = cartValue--;
    notifyListeners();
  }

   addMovieTocart(String imageUrl, int price, String title, DateTime year, List genre, BuildContext context) async {
    var _isAdded = await _fireStoreService.getIfItemAdded(title);
    if(_isAdded == true){
      return _fireStoreService.addToCart(imageUrl, price, title, year, genre);
    }
    else
      Flushbar(
              title: "Ooops",
              flushbarPosition: FlushbarPosition.TOP,
              message: 'Item already exist in Cart',
              duration: Duration(seconds: 2),
            ).show(context);    
  }
 
// switch {= 
//   case AppState.idle: 
// }


}
 

import 'package:flutter/material.dart';
import 'package:movie_mart/core/model/purchase_model.dart';
import 'package:movie_mart/core/services/firestoreServices.dart';
import 'package:movie_mart/ui/widget/purchase_tile.dart';
import 'package:movie_mart/utils/baseModel/baseModel.dart';
import 'package:movie_mart/utils/constants/locator.dart';
import 'package:movie_mart/utils/router/navigationService.dart';

class PurchaseHistoryViewModel extends BaseModel{
     final NavigationService _navigationService = locator<NavigationService>();
     final FireStoreService _firestoreService = locator<FireStoreService>();
     List<ListViewScreenModel> screens;

  getScreens() {
    try{
      setBusy(true);
  ListViewScreenModel screensModel = new ListViewScreenModel();
  var data =  _firestoreService.getPurchase();
  for (int i = 0; i < data.docs.length; i++) {
    var imageUrl = data.docs[i].data()["imageUrl"];
    var title = data.docs[i].data()["title"];
    int price = data.docs[i].data()["price"];
    int quantity = data.docs[i].data()["quantity"];
    int year = data.docs[i].data()["year"];
    int avQt = data.docs[i].data()["year"];
    List genre = data.docs[i].data()["genre"];
    // DateTime dateTime = getMovies().docs[i].data()["dateTime"];
    DateTime purchaseDate = data.docs[i].date()["purchaseDate"];

    screensModel.setImage(imageUrl.toString());
    screensModel.setTitle(title.toString());
    screensModel.setPrice(price);
    screensModel.setPrice(quantity);
    screensModel.setYear(year);
    screensModel.setAvQt(avQt);
    screensModel.setGenre(genre);
    screensModel.setPurchaseDate(purchaseDate); 
    screens.add(screensModel);  
  }
  setBusy(false);
  return screens;
}catch(e){
setBusy(false);
print(e);
}
  }

   pop(){
    return _navigationService.pop();
  }

  // getPurchaseHistory(){
  //   return null;
  // }

  void animatedRemoveFromList(GlobalKey<AnimatedListState> _listKey, String title) {
      final index = screens.indexWhere((u) => u.title == title);
      var user = screens.removeAt(index);
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
              child: PurchaseTile(model:user),
            ),
          );
        },
        duration: const Duration(milliseconds: 600),
      );
      notifyListeners();
  }

}



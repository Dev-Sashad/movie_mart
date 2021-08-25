import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_mart/utils/baseModel/baseModel.dart';
import 'package:movie_mart/utils/constants/helpers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FireStoreService extends BaseModel {
  final firestoreInstance = FirebaseFirestore.instance;

  addToCart(String imageUrl, int price, String title, DateTime year, List genre) async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = FirebaseAuth.instance.currentUser.uid;
    firestoreInstance.runTransaction((Transaction transaction) async {
      CollectionReference reference = firestoreInstance
          .collection('user')
          .doc(userId)
          .collection('cart');
      DateTime time = formatDate(year);
      await reference.add({
        "imageUrl": imageUrl.toString(),
        "quantity": 1,
        "price": price,
        "title": title,
        "year": time,
        "genre": genre
      });
    }).then((value) =>  showErrorToast('Item Added to Cart'));
  }

  getIfItemAdded(String title){
     String userId = FirebaseAuth.instance.currentUser.uid;
    return firestoreInstance
        .collection('user').doc(userId).collection('cart').where('title', isEqualTo: title)
        .snapshots().isEmpty;
  }

  deleteFromCart(var data){
    FirebaseFirestore.instance.runTransaction((transaction) async{
                        DocumentSnapshot snapShot = await transaction.get(data);
                        transaction.delete(snapShot.reference);
                      });
        notifyListeners();
  }

  updateItemQuantity(String documentId, int newQuantity, int newPrice){
     String userId = FirebaseAuth.instance.currentUser.uid;
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('cart')
        .doc(documentId);
    FirebaseFirestore.instance.runTransaction((Transaction transaction) async {
      transaction.update(documentReference, {"quantity": newQuantity, "price": newPrice});
      return newQuantity;
    });
    notifyListeners();
  }

  addPurchase(String imageUrl, int quantity, int price, String title, DateTime year,DateTime date, List genre) async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = FirebaseAuth.instance.currentUser.uid;
    firestoreInstance.runTransaction((Transaction transaction) async {
      CollectionReference reference = firestoreInstance
          .collection('user')
          .doc(userId)
          .collection('Purchase');
      DateTime _time = formatDate(date);
      DateTime _year = formatDate(year);
      await reference.add({
        "imageUrl": imageUrl.toString(),
        "quantity": quantity,
        "price": price,
        "title": title,
        "year": _year,
        "purchase_date": _time,
        "genre": genre
      });
    }).then((value) =>  showErrorToast('Your Order is SuccessFul'));
  }
 
  // getPageViewMovies() async {
  //   return firestoreInstance
  //       .collection('movies').orderBy("time").limit(5)
  //       .get();
  // }

  // getMovies(String genre) async {
  //   return firestoreInstance
  //       .collection('movies').orderBy("time").where('genre' , isEqualTo: genre )
  //       .get();
  // }

   getPurchase() async {
    String userId = FirebaseAuth.instance.currentUser.uid;
    return firestoreInstance
        .collection('user').doc(userId).collection('purchase').orderBy("time")
        .get();
  }

  getCartItems() async {
    setBusy(true);
    String userId = FirebaseAuth.instance.currentUser.uid;
    return firestoreInstance
        .collection('user').doc(userId).collection('cart').orderBy("time")
        .get().then((value) => setBusy(false));
  }

//   getSales() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String userIdentity = prefs.getString('userIdentity');
//     return FirebaseFirestore.instance
//         .collection('users')
//         .doc(userIdentity)
//         .collection('sales')
//         .orderBy('Date', descending: true)
//         .limit(100)
//         .get();
//   }

//   getStocks() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String userIdentity = prefs.getString('userIdentity');
//     return FirebaseFirestore.instance
//         .collection('users')
//         .doc(userIdentity)
//         .collection('stockList')
//         .orderBy("quantity")
//         .get();
//   }

//   addStock(String documentId, int actualQuantity) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String userIdentity = prefs.getString('userIdentity');
//     DocumentReference documentReference = FirebaseFirestore.instance
//         .collection('users')
//         .doc(userIdentity)
//         .collection('stockList')
//         .doc(documentId);
//     FirebaseFirestore.instance.runTransaction((Transaction transaction) async {
//       DocumentSnapshot snapshot = await transaction.get(documentReference);
//       int newQuantity = snapshot.data()['quantity'] + actualQuantity;
//       print('new Quantity=$newQuantity');

//       transaction.update(documentReference, {"quantity": newQuantity});
//       return newQuantity;
//     });
//   }


//    updatePrice(String documentId, int newUnitPrice) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String userIdentity = prefs.getString('userIdentity');
//     DocumentReference documentReference = FirebaseFirestore.instance
//         .collection('users')
//         .doc(userIdentity)
//         .collection('stockList')
//         .doc(documentId);
//     FirebaseFirestore.instance.runTransaction((Transaction transaction) async {
//       transaction.update(documentReference, {"price": newUnitPrice});
//       return newUnitPrice;
//     });
//   }

//   sell(String selectedItem, int newPrice, int actualQuantity,
//       String newDateTime, documentId) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String userIdentity = prefs.getString('userIdentity');
//     DocumentReference documentReference = FirebaseFirestore.instance
//         .collection('users')
//         .doc(userIdentity)
//         .collection('stockList')
//         .doc(documentId);
//     firestoreInstance.runTransaction((Transaction transaction) async {
//       CollectionReference reference = FirebaseFirestore.instance
//           .collection('users')
//           .doc(userIdentity)
//           .collection('sales');
//       await reference.add({
//         "Item": selectedItem,
//         "Price": newPrice,
//         "Quantity_sold": actualQuantity,
//         "Date": newDateTime,
//         //"Time": newTime,
//       });

//       DocumentSnapshot snapshot = await transaction.get(documentReference);
//       int newQuantity = snapshot.data()['quantity'] - actualQuantity;
//       print('new Quantity=$newQuantity');

//       transaction.update(documentReference, {"quantity": newQuantity});

//       return newQuantity;
//     });
//   }
 }

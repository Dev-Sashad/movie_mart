import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie_mart/core/model/error_model.dart';
import 'package:movie_mart/core/model/genre_model.dart';
import 'package:movie_mart/core/model/movie_model.dart';
import 'package:movie_mart/core/services/api_service.dart';
import 'package:movie_mart/core/services/authentication.dart';
import 'package:movie_mart/core/services/firestoreServices.dart';
import 'package:movie_mart/utils/baseModel/baseModel.dart';
import 'package:movie_mart/utils/constants/colors.dart';
import 'package:movie_mart/utils/constants/locator.dart';
import 'package:movie_mart/utils/router/navigationService.dart';
import 'package:movie_mart/utils/router/routeNames.dart';

class DashboardViewModel extends BaseModel {
  final FireStoreService _firestoreService = locator<FireStoreService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authentication = locator<AuthService>();
  final MovieApiService _movies = locator<MovieApiService>();
  List<Results> data;
  List<Genres> genre;
  String searchValue;
  // List<PageViewScreenModel> screens = getScreens();
  int currentIndex = 0;
  int get currentIdx => currentIndex;
  EdgeInsetsGeometry padding = EdgeInsets.only(left: 30);
  
  // getMovies() {
  //   return _firestoreService.getPageViewMovies();
  // }

  getMovies() async {
    setBusy(true);
    var result = await _movies.getMovies();
    if (result is ErrorModel) {
      print(result.error);
      notifyListeners();
      setBusy(false);
      throw Exception('Failed to load internet');
    }
    print('WORKKING');
    var value = json.decode(result.data["results"]);
    print(json.decode(result.data));
    data = List<Results>.from(value.map((item) => Results.fromJson(item)));
    setBusy(false);
    print(data);
    return data;
  }

  getGenres() async {
    setBusy(true);
    var result = await _movies.getGenre();
    if (result is ErrorModel) {
      print(result.error);
      notifyListeners();
      setBusy(false);
      throw Exception('Failed to load internet');
    }
    print('WORKKING');
    var value = json.decode(result.data["genres"]);
    print(json.decode(result.data));
    genre = List<Genres>.from(value.map((item) => Genres.fromJson(item)));
    setBusy(false);
    print(genre);
    return genre;
  }
  
  pop() {
    _navigationService.pop();
  }

  setPageViewIndex(int value){
    currentIndex = value;
    notifyListeners();
  }

  signout() {
    _authentication.signout();
    _navigationService.navigateReplacementTo(SignInPageRoute);
  }

  Widget pageIndicator(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 10.0,
      width: isCurrentPage ? 10.0 : 10.0,
      decoration: BoxDecoration(
          color: isCurrentPage ? AppColors.primaryColor : AppColors.grey_light,
          borderRadius: BorderRadius.circular(12)),
    );
  }
}

// class PageViewScreenModel {
//   String image;
//   String title;
//   int year;
//   int price;
//   int avQt;
//   Map genre;
//   String movieId;

//   PageViewScreenModel({this.image, this.title, this.price,
//                        this.genre, this.avQt, this.year, this.movieId});

//   void setImage(String getImage) {
//     image = getImage;
//   }

//   void setTitle(String getTitle) {
//     title = getTitle;
//   }

//   void setPrice(int getPrice) {
//     price = getPrice;
//   }

//   void setAvQt(int getAvQt) {
//     avQt = getAvQt;
//   }

//   void setYear(int getYear) {
//     year = getYear;
//   }

//   void setGenre(Map getGenre) {
//     genre = getGenre;
//   }

//    void setMovieId(String getMovieId) {
//     movieId = getMovieId;
//   }



//   String getImage() {
//     return image;
//   }

//   String getTitle() {
//     return title;
//   }

//   int getPrice() {
//     return price;
//   }

//   int getAvQt() {
//     return avQt;
//   }

//   int getYear() {
//     return year;
//   }

//   Map getGenre(){
//     return genre;
//   }

//    String getMovieid(){
//     return movieId;
//   }

  
// }

// List<PageViewScreenModel> getScreens() {
//   List<PageViewScreenModel> screens = [];
//   PageViewScreenModel screensModel = new PageViewScreenModel();
//   final FireStoreService _firestoreService = locator<FireStoreService>();

//    getMovies() {
//     return _firestoreService.getPageViewMovies();
//   }

//   for (int i = 0; i < getMovies().docs.length; i++) {
//     var imageUrl = getMovies().docs[i].data()["imageUrl"];
//     var title = getMovies().docs[i].data()["title"];
//     int price = getMovies().docs[i].data()["price"];
//     int year = getMovies().docs[i].data()["year"];
//     int avQt = getMovies().docs[i].data()["year"];
//     Map genre = getMovies().docs[i].data()["genre"];
//     String movieId = getMovies().docs[i].id;

//     screensModel.setImage(imageUrl.toString());
//     screensModel.setTitle(title.toString());
//     screensModel.setPrice(price);
//     screensModel.setYear(year);
//     screensModel.setAvQt(avQt);
//     screensModel.setGenre(genre);
//     screensModel.setMovieId(movieId);
//     screens.add(screensModel);

//    // return screens;
//   }
//   return screens;
// }
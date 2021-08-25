// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:movie_mart/core/model/error_model.dart';
// import 'package:movie_mart/core/model/genre_model.dart';
// import 'package:movie_mart/core/model/movie_model.dart';
// import 'package:movie_mart/core/services/api_service.dart';
// import 'package:movie_mart/core/services/firestoreServices.dart';
// import 'package:movie_mart/utils/baseModel/baseModel.dart';
// import 'package:movie_mart/utils/constants/locator.dart';
// import 'package:movie_mart/utils/router/navigationService.dart';

// class MovieListViewModel extends BaseModel {
//   final FireStoreService _firestoreService = locator<FireStoreService>();
//   final NavigationService _navigationService = locator<NavigationService>();
//   final MovieApiService _movies = locator<MovieApiService>();
//   List<Results> data;
//   List<Genres> genre;
  

//   getMovies() async {
//     setBusy(true);
//     var result = await _movies.getMovies();
//     if (result is ErrorModel) {
//       print(result.error);
//       notifyListeners();
//       setBusy(false);
//       throw Exception('Failed to load internet');
//     }
//     print('WORKKING');
//     var value = json.decode(result.data["results"]);
//     print(json.decode(result.data));
//     data = List<Results>.from(value.map((item) => Results.fromJson(item)));
//     setBusy(false);
//     print(data);
//     return data;
//   }

//   getGenres() async {
//     setBusy(true);
//     var result = await _movies.getGenre();
//     if (result is ErrorModel) {
//       print(result.error);
//       notifyListeners();
//       setBusy(false);
//       throw Exception('Failed to load internet');
//     }
//     print('WORKKING');
//     var value = json.decode(result.data["genres"]);
//     print(json.decode(result.data));
//     genre = List<Genres>.from(value.map((item) => Genres.fromJson(item)));
//     setBusy(false);
//     print(genre);
//     return genre;
//   }

//   EdgeInsetsGeometry padding = EdgeInsets.only(left: 30);

//   addMovieTocart(String imageUrl, int price, String title, DateTime year) {
//     return _firestoreService.addToCart(imageUrl, price, title, year);
//   }

//   pop() {
//     _navigationService.pop();
//   }
// }

// class ListViewScreenModel {
//   String image;
//   String title;
//   String movieId;
//   int year;
//   int price;
//   int avQt;
//   Map genre;

//   ListViewScreenModel({this.image, this.title, this.price,
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

//   String getMovieid(){
//     return movieId;
//   }

  
// }

// List<ListViewScreenModel> getScreens(String genre) {
//   List<ListViewScreenModel> screens = [];
//   ListViewScreenModel screensModel = new ListViewScreenModel();
//   final FireStoreService _firestoreService = locator<FireStoreService>();

//    getMovies() {
//     return _firestoreService.getMovies(genre);
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

//     return screens;
//   }
//   return screens;
// }
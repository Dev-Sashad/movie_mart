

import 'package:movie_mart/core/model/error_model.dart';
import 'package:movie_mart/core/model/genre_model.dart';
import 'package:movie_mart/core/model/movie_model.dart';
import 'package:movie_mart/core/model/success_model.dart';
import 'package:movie_mart/utils/constants/helpers.dart';
import 'package:movie_mart/utils/http/api_keys.dart';
import 'package:movie_mart/utils/http/paths.dart';

import 'index.dart';

class MovieApiService {


  getMovies() async {
    try {
      final result = await http.get(Paths.fetchMovies + apiKey + Paths.completeUrl);
      if (result is ErrorModel) {
        print("ERROR");
        showErrorToast('Fetch failed');
        print(result.error);
        var data = result.error;
        List<Results> postList = List<Results>.from(
            data.map((item) => MovieModel.fromJson(item)));
         return ErrorModel(postList);

      }

        print('goooooal');
      return SuccessModel(result);
    } catch (e) {
      print(e.toString());
      return ErrorModel('$e');
    }
  }

  getGenre() async{
     try {
      final result = await http.get("/3/genre/movie/list?api_key=" + apiKey + Paths.completeUrl);
      if (result is ErrorModel) {
        print("ERROR");
        showErrorToast('Fetch failed');
        print(result.error);
        var data = result.error;
        List<Genre> postList = List<Genre>.from(
            data.map((item) => Genre.fromJson(item)));
         return ErrorModel(postList);

      }

        print('goooooal');
      return SuccessModel(result);
    } catch (e) {
      print(e.toString());
      return ErrorModel('$e');
    }
  }
}

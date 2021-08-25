import 'package:get_it/get_it.dart';
import 'package:movie_mart/core/services/api_service.dart';
import 'package:movie_mart/core/services/authentication.dart';
import 'package:movie_mart/core/services/firestoreServices.dart';
import 'package:movie_mart/utils/dialogeManager/dialogService.dart';
import 'package:movie_mart/utils/router/navigationService.dart';


GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => ProgressService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => FireStoreService());
  locator.registerLazySingleton(() => MovieApiService());
}

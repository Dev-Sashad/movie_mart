

import 'package:movie_mart/core/services/authentication.dart';
import 'package:movie_mart/utils/baseModel/baseModel.dart';
import 'package:movie_mart/utils/constants/locator.dart';

class SplashscreenViewModel extends BaseModel{
final AuthService _authentication = locator<AuthService>();

isuserloggedin() {
 _authentication.getCurrentUser();
}

}
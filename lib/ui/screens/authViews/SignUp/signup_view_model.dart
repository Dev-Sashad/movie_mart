import 'package:flutter/cupertino.dart';
import 'package:movie_mart/core/services/authentication.dart';
import 'package:movie_mart/utils/baseModel/baseModel.dart';
import 'package:movie_mart/utils/constants/locator.dart';
import 'package:movie_mart/utils/constants/validator.dart';
import 'package:movie_mart/utils/router/navigationService.dart';
import 'package:movie_mart/utils/router/routeNames.dart';

class SignUpViewModel extends BaseModel {
    bool _visiblePassword = false;
  bool get visiblePassword => _visiblePassword;
  final AuthService _authentication = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();

  setvisiblePassword() {
    _visiblePassword = !_visiblePassword;
    notifyListeners();
  }

void submit(GlobalKey<FormState> formKey, String email, String password, String bussinessName) async {
if (validate(formKey)){
  try{
  _authentication.signUp(email, password, bussinessName);
  }catch(e){
    print(e);
  }
 }
  }

  void navigateToSignUp() {
    _navigationService.navigateReplacementTo(SignInPageRoute);
  }

}
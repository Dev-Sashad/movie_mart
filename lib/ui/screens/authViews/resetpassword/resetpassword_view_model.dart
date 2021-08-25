import 'package:flutter/material.dart';
import 'package:movie_mart/core/services/authentication.dart';
import 'package:movie_mart/utils/baseModel/baseModel.dart';
import 'package:movie_mart/utils/constants/locator.dart';
import 'package:movie_mart/utils/constants/validator.dart';
import 'package:movie_mart/utils/router/navigationService.dart';




class ResetPasswordViewModel extends BaseModel {
  bool _visiblePassword = false;
  bool get visiblePassword => _visiblePassword;
  final AuthService _authentication = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();

  setvisiblePassword() {
    _visiblePassword = !_visiblePassword;
    notifyListeners();
  }

  resetpassword(String oldPassword, String newPassword, GlobalKey<FormState> formKey){
    
      if (validate(formKey)){
       try{
         _authentication.resetpassword(oldPassword, newPassword);
       }catch(e){
         print(e);
       }     
          }
    }

      void pop() {
    _navigationService.pop();
  }

}

    
              


 
 
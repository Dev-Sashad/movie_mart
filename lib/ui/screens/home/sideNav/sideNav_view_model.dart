import 'package:movie_mart/core/services/authentication.dart';
import 'package:movie_mart/utils/baseModel/baseModel.dart';
import 'package:movie_mart/utils/constants/locator.dart';
import 'package:movie_mart/utils/router/navigationService.dart';
import 'package:movie_mart/utils/router/routeNames.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideNavViewModel extends BaseModel {
 
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authentication = locator<AuthService>();
  
  //String bussinessName;

  Future<void> displayName() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString('userName');
  }

    void pop(){
      _navigationService.pop();
    }
 

getUser() async {
 _authentication.getCurrentUser();
 SharedPreferences prefs = await SharedPreferences.getInstance();
 return prefs.getString('userEmail');
}

  void navigateToResetPassword() {   
    _navigationService.navigateTo(ResetPasswordRoute);
  }

 

   void   signout(){
      
          _authentication.signout();
        _navigationService.navigateReplacementTo(SignInPageRoute);
      }

}
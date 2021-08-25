
import 'package:movie_mart/utils/baseModel/baseModel.dart';
import 'package:movie_mart/utils/constants/locator.dart';
import 'package:movie_mart/utils/router/navigationService.dart';

class HelpViewModel extends BaseModel {
    final NavigationService _navigationService = locator<NavigationService>();

   pop(){
    return _navigationService.pop();
  }

}
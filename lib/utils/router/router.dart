import 'package:flutter/material.dart';
import 'package:movie_mart/ui/screens/authViews/SignUp/signup.dart';
import 'package:movie_mart/ui/screens/authViews/login/loginpage.dart';
import 'package:movie_mart/ui/screens/authViews/resetpassword/resetpassword.dart';
import 'package:movie_mart/ui/screens/home/homepage/homepage.dart';
import 'package:movie_mart/utils/router/routeNames.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {

    case HomePageRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: HomePage(),
      );

        case SignInPageRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: LogInPage(),
      );

         case SignUpPageRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: SignUpView(),
      );

    

           case ResetPasswordRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ResetPasswordpage(),
      );

   




    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}')),
              ));
  }
}

PageRoute _getPageRoute({String routeName, Widget viewToShow}) {
  return MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => viewToShow);
}

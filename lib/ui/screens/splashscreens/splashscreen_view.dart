                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:movie_mart/ui/screens/home/homepage/homepage.dart';
import 'package:movie_mart/ui/screens/splashscreens/splashscreen_view_model.dart';
import 'package:movie_mart/utils/constants/colors.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';

class SplashscreenView extends StatelessWidget {
  const SplashscreenView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<SplashscreenViewModel>.withConsumer(
        viewModelBuilder: () => SplashscreenViewModel(),
        builder: (context, model, child) {
        return SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(context).size.height,
              width:MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: AnimatedSplashScreen(
            centered: true,
            backgroundColor: AppColors.white ,
            splash: Align(
                alignment: Alignment.center,
                child: Image.asset('assets/images/logo.png',),
             
              ),
            splashIconSize: 200,
            splashTransition: SplashTransition.scaleTransition,
            nextScreen: HomePage(),
              ),
      ),
        );
        }
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movie_mart/core/services/authentication.dart';
import 'package:movie_mart/ui/widget/generalButton.dart';
import 'package:movie_mart/ui/widget/generalForm.dart';
import 'package:movie_mart/utils/baseModel/baseModel.dart';
import 'package:movie_mart/utils/constants/colors.dart';
import 'package:movie_mart/utils/constants/locator.dart';
import 'package:movie_mart/utils/constants/textstyle.dart';
import 'package:movie_mart/utils/constants/validator.dart';
import 'package:movie_mart/utils/router/navigationService.dart';
import 'package:movie_mart/utils/router/routeNames.dart';

class LogInPageModel extends BaseModel {
  final forgetPasswordformKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  BuildContext context;
  String email = '', password = '';
  bool _visiblePassword = true;
  bool get visiblePassword => _visiblePassword;
  final AuthService _authentication = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();

  setvisiblePassword() {
    _visiblePassword = !_visiblePassword;
    notifyListeners();
  }

  void submit(GlobalKey<FormState> formKey) async {
    //signIn user
    if (validate(formKey)) {
      try {
        _authentication.login(email, password);
      } catch (e) {
        print(e);
      }
    }
  }

  void navigateToSignUp() {
    _navigationService.navigateReplacementTo(SignUpPageRoute);
  }


  void forget(GlobalKey<FormState> formKey, String email) async {
    if (validate(formKey)) {
      try {
        _authentication.forgotpassword(email);
        _navigationService.pop();
      } catch (e) {
        print(e);
      }
    }
  }

  void pop() {
    _navigationService.pop();
  }

  void forgetPasswodDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Forget Password',
                    style: TextStyle(
                      fontSize: 20,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Caros',
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      pop();
                    },
                    icon: Icon(
                      Icons.cancel,
                      color: AppColors.grey,
                    ),
                  ),
                ]),
            content:  Form(
               key: formKey,
               child: CustomTextFormField(
              hasPrefixIcon: true,
              prefixIcon: Icon(Icons.mail, color: AppColors.grey),
              label: "Email",
              borderStyle: BorderStyle.solid,
              textInputType: TextInputType.emailAddress,
              controller: emailController,
              onChanged: (value) {
                email = value;
              },
              validator: emailValidator,
               )
            ),
            actions: <Widget>[
              CustomButton(
                  child: Text('reset', style: buttonTextStyle),
                  onPressed: () {
                    forget(formKey, email);
                  }),
            ],
          );
        });
  }
}

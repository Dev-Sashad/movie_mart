import 'package:flutter/material.dart';
import 'package:movie_mart/ui/screens/authViews/resetpassword/resetpassword_view_model.dart';
import 'package:movie_mart/ui/widget/generalButton.dart';
import 'package:movie_mart/ui/widget/generalForm.dart';
import 'package:movie_mart/utils/constants/colors.dart';
import 'package:movie_mart/utils/constants/screensize.dart';
import 'package:movie_mart/utils/constants/textstyle.dart';
import 'package:movie_mart/utils/constants/validator.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
class ResetPasswordpage extends StatefulWidget {
  @override
  ResetPasswordpageState createState() => ResetPasswordpageState();
}

class ResetPasswordpageState extends State<ResetPasswordpage> {
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  String oldPassword, newPassword;

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<ResetPasswordViewModel>.withConsumer(
        viewModelBuilder: () => ResetPasswordViewModel(),
        builder: (context, model, child) {
          return GestureDetector(
            onTap:(){
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                automaticallyImplyLeading: false,
                leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios, color:AppColors.white),
                    onPressed: () {
                      model.pop();
                    }),
                backgroundColor: Colors.orangeAccent,
                title: Text('Change Password',
                    textAlign: TextAlign.center, style: appBartextStyle,),
                centerTitle: true,
              ),
              body: ListView(children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                      key: formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: sizeboxheight(context)),
                            CustomTextFormField(
                              label: "Oldpassword",
                              borderStyle: BorderStyle.solid,
                              textInputType: TextInputType.visiblePassword,
                              obscured: model.visiblePassword,
                              hasSuffixIcon: true, // suffix icon enabled
                              controller: passwordController,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  model.setvisiblePassword();
                                }, // changes the password visibility
                                icon: Icon(
                                  model.visiblePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: AppColors.grey_light,
                                ),
                              ),
                              onChanged: (value) {
                                oldPassword = value;
                              },
                              validator: passwordValidator,
                            ),
                            SizedBox(height: sizeboxheight(context)),
                            CustomTextFormField(
                              label: "Oldpassword",
                              borderStyle: BorderStyle.solid,
                              textInputType: TextInputType.visiblePassword,
                              obscured: model.visiblePassword,
                              hasSuffixIcon: true, // suffix icon enabled
                              controller: passwordController,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  model.setvisiblePassword();
                                }, // changes the password visibility
                                icon: Icon(
                                  model.visiblePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: AppColors.grey_light,
                                ),
                              ),
                              onChanged: (value) {
                                newPassword = value;
                              },
                              validator: passwordValidator,
                            ),
                          ])),
                ),
                SizedBox(height: sizeboxheight(context) * 2),
                Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomButton(
                      child: Text('Change Password', style: buttonTextStyle),
                      onPressed: () {
                        model.resetpassword(oldPassword, newPassword, formKey);
                      }),
                ),
              ]),
            ),
          );
        });
  }
}

class Responsive {
}

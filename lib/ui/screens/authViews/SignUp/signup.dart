import 'package:flutter/material.dart';
import 'package:movie_mart/ui/screens/authViews/SignUp/signup_view_model.dart';
import 'package:movie_mart/ui/widget/generalButton.dart';
import 'package:movie_mart/ui/widget/generalForm.dart';
import 'package:movie_mart/utils/constants/colors.dart';
import 'package:movie_mart/utils/constants/screensize.dart';
import 'package:movie_mart/utils/constants/textstyle.dart';
import 'package:movie_mart/utils/constants/validator.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  String email, password, bussinessName;

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<SignUpViewModel>.withConsumer(
        viewModelBuilder: () => SignUpViewModel(),
        builder: (context, model, child) {
          return GestureDetector(
            onTap:(){
              FocusScope.of(context).unfocus();
            },
            child: SafeArea(
                child: Scaffold(
                    body: SingleChildScrollView(
                        child: Container(
                            decoration: BoxDecoration(color: Colors.white),
                            height: height(1, context),
                            width: width(1, context),
                            child: Column(children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top: 30),
                                height: height(0.36, context),
                                width: width(1, context),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    colors: [
                                      Colors.orangeAccent[200],
                                      Colors.orangeAccent,
                                      Colors.orangeAccent[100],
                                    ],
                                  ),
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(50)),
                                ),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/logo.png',
                                      height: MediaQuery.of(context).size.height *
                                          0.2,
                                      alignment: Alignment.center,
                                    ),
                                    Container(
                                        alignment: Alignment.topLeft,
                                        margin: EdgeInsets.fromLTRB(15, 5, 0, 0),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('SIGN UP',
                                                  style: headertextStyle,
                                                  textAlign: TextAlign.left),
                                              SizedBox(height: 1),
                                              Text(
                                                  'your most reliable movie plug',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                      fontStyle:
                                                          FontStyle.italic),
                                                  textAlign: TextAlign.left)
                                            ]))
                                  ],
                                ),
                              ),
                              SizedBox(height: 5),
                              Expanded(
                                child: Container(
                                    color: Colors.white,
                                    child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                15, 0, 15, 15),
                                            child: Form(
                                              key: formKey,
                                              child: ListView(
                                                 shrinkWrap: true,
                                                 scrollDirection: Axis.vertical,
                                                  children: [
                                                 
                                                    CustomTextFormField(
                                                      hasPrefixIcon: true,
                                                      prefixIcon: Icon(Icons.mail,
                                                          color: AppColors.grey),
                                                      label: "full name",
                                                      borderStyle:
                                                          BorderStyle.solid,
                                                      textInputType: TextInputType
                                                          .emailAddress,
                                                      controller: emailController,
                                                      onChanged: (value) {
                                                        bussinessName = value;
                                                      },
                                                      validator: (value){
                                                         return value.isEmpty ? 'field cannot be empty': null;
                                                        },
                                                    ),
                                                    CustomTextFormField(
                                                      hasPrefixIcon: true,
                                                      prefixIcon: Icon(Icons.mail,
                                                          color: AppColors.grey),
                                                      label: "email",
                                                      borderStyle:
                                                          BorderStyle.solid,
                                                      textInputType: TextInputType
                                                          .emailAddress,
                                                      controller: emailController,
                                                      onChanged: (value) {
                                                        email = value;
                                                      },
                                                     validator: emailValidator,
                                                    ),
                                                    
                                                    CustomTextFormField(
                                                      label: "password",
                                                      borderStyle:
                                                          BorderStyle.solid,
                                                      textInputType: TextInputType
                                                          .visiblePassword,
                                                      obscured:
                                                          model.visiblePassword,
                                                      hasSuffixIcon:
                                                          true, // suffix icon enabled
                                                      controller:
                                                          passwordController,
                                                      suffixIcon: IconButton(
                                                        onPressed: () {
                                                          model
                                                              .setvisiblePassword();
                                                        }, // changes the password visibility
                                                        icon: Icon(
                                                          model.visiblePassword
                                                              ? Icons
                                                                  .visibility_off
                                                              : Icons.visibility,
                                                          color: AppColors
                                                              .grey_light,
                                                        ),
                                                      ),
                                                      onChanged: (value) {
                                                        password = value;
                                                      },
                                                      validator: passwordValidator,
                                                    ),
                                                    SizedBox(
                                                        height: sizeboxheight(
                                                                context)),
                                                    CustomButton(
                                                        child: Text('Sign Up',
                                                            style:
                                                                buttonTextStyle),
                                                        onPressed: () {
                                                          model.submit(
                                                              formKey,
                                                              email,
                                                              password,
                                                              bussinessName);
                                                        }),
                                                    SizedBox(
                                                        height:sizeboxheight(
                                                                context)),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Text(
                                                          'Already have an account?  ',
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .black),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            model
                                                                .navigateToSignUp();
                                                          },
                                                          child: Text(
                                                            'Login',
                                                            style: TextStyle(
                                                              color:
                                                                  AppColors.red,
                                                              // fontWeight: FontWeight.bold
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ]),
                                            ),
                                          ),
                                       ),
                              )
                            ]))))),
          );
        });
  }
}

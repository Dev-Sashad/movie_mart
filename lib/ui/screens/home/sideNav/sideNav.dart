import 'package:flutter/material.dart';
import 'package:movie_mart/ui/widget/MenuItem/menuitem.dart';
import 'package:movie_mart/utils/constants/colors.dart';
import 'package:movie_mart/utils/constants/screensize.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'sideNav_view_model.dart';

class SideNavpage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
   return ViewModelProvider<SideNavViewModel>.withConsumer(
      viewModelBuilder: () => SideNavViewModel(),
      builder: (context, model, child) {
          return  Drawer(
              elevation: 8.0,
              child: SafeArea(
                child: Container(
                    padding: EdgeInsets.fromLTRB(5, 50, 0, 0),
                    color: AppColors.primaryColor,
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: <Widget>[
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: height(0.1, context),
                                   backgroundColor: AppColors.white, 
                                    child: Text(model.displayName().toString().substring(0,1) ,style: TextStyle(fontSize:20, color: AppColors.primaryColor))),

                                     SizedBox(height: sizeboxheight(context)*0.5,),
                                     Text(model.displayName().toString(), style: TextStyle(fontSize:20, color: AppColors.white))
                                ],
                              )
                            ),

                             SizedBox(height: sizeboxheight(context)*2,),

                            MenuItem(
                              icon: Icons.add,
                              title: 'My cart',
                              onTap: () {
                            model.pop();   
                               
                              },
                            ),
                                MenuItem(
                              icon: Icons.add,
                              title: 'Purchase history',
                              onTap: () {
                                model.pop();
                                
                              },
                            ),
                            
                            MenuItem(
                              icon: Icons.lock,
                              title: 'Change Password',
                              onTap: () {
                                 model.pop();
                                model.navigateToResetPassword();
                              },
                            ),
                 
                            MenuItem(
                              icon: Icons.show_chart,
                              title: 'Add card',
                              onTap: () {
                               model.pop();
                              },
                            ),
                            MenuItem(
                              icon: Icons.settings,
                              title: 'Settings',
                              onTap: () {
                                model.pop();
                              },
                            ),

                            MenuItem(
                              icon: Icons.settings,
                              title: 'help',
                              onTap: () {
                                model.pop();
                              },
                            ),
                          ],
                        ),

                              MenuItem(
                              icon: Icons.person,
                              title: 'LogOut',
                              onTap: () {
                                model.pop();
                               model.signout();
                              },
                            ),
                      ],
                    ) 
                    ),
              ),
          );
        });
  }
}

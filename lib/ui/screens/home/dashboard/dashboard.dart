import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_mart/ui/screens/home/sideNav/sideNav.dart';
import 'package:movie_mart/ui/screens/otherViews/movie_list/movie_list.dart';
import 'package:movie_mart/ui/widget/dashboardButton.dart';
import 'package:movie_mart/ui/widget/generalForm.dart';
import 'package:movie_mart/ui/widget/movie_tile.dart';
import 'package:movie_mart/utils/constants/colors.dart';
import 'package:movie_mart/utils/constants/screensize.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'dashboard_view_model.dart';

// ignore: must_be_immutable
class Dashboard extends StatelessWidget {
  final searchController = TextEditingController();
  Orientation orientation;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  PageController pageController = new PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    int _index = Random().nextInt(2)*3;
    return ViewModelProvider<DashboardViewModel>.withConsumer(
        viewModelBuilder: () => DashboardViewModel(),
        builder: (context, model, child) {
          return Scaffold(
              key: _scaffoldKey,
              extendBodyBehindAppBar: false,
              backgroundColor: AppColors.white,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                leading: GestureDetector(
                  onTap: () {
                    _scaffoldKey.currentState.openDrawer();
                  },
                  child: Icon(
                    Icons.menu,
                    color: AppColors.primaryColor,
                  ),
                ),
                title: CustomTextFormField(
                  hasPrefixIcon: true,
                  prefixIcon: Icon(Icons.mail, color: AppColors.grey),
                  hintText: "search",
                  borderStyle: BorderStyle.solid,
                  textInputType: TextInputType.text,
                  controller: searchController,
                  onChanged: (value) {
                    model.searchValue = value;
                  },
                ),
                centerTitle: true,
                actions: <Widget>[
                  TextButton(
                    onPressed: () {},
                    child: Stack(
                      children: [
                        Icon(
                          (Icons.shopping_cart_outlined),
                          color: AppColors.primaryColor,
                        ),
                        Positioned(
                            right: -10,
                            child: CircleAvatar(
                                backgroundColor: AppColors.white,
                                radius: 4,
                                child: Text(model.cartValue.toString(),
                                    style: TextStyle(
                                        color: AppColors.black, fontSize: 5)))),
                      ],
                    ),
                  ),
                ],
                elevation: 0,
              ),
              resizeToAvoidBottomInset: false,
              drawer: SideNavpage(),
              body: SingleChildScrollView(
                child: Column(children: [
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.symmetric(vertical: 7),
                    height: height(0.25, context),
                    child:  PageView.builder(
                          scrollDirection: Axis.horizontal,
                          controller: pageController,
                          itemCount: 8,
                          onPageChanged: (value) {
                            model.setPageViewIndex(value);
                          },
                          itemBuilder: (context, index) {
                            if (model.data.isNotEmpty) {
                              return MovieTile(
                                result: model.data[_index], 
                                genre: model.genre.toList(),
                                cwidth: 0.7,
                                cheight: 0.3,
                                iheight: 0.2,
                                iwidth: 0.7,
                              );
                            } else
                              return Container(
                                width: width(0.7, context),
                                height: height(0.2, context),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 4, color: Colors.black12)
                                    ]),
                              );
                          })             
                  ),
                  SizedBox(height: sizeboxheight(context)),
                  Container(
                    padding: model.padding,
                    child: Row(
                      children: <Widget>[
                        for (int i = 0; i < 8; i++)
                          model.currentIdx == i
                              ? model.pageIndicator(true)
                              : model.pageIndicator(false)
                      ],
                    ),
                  ),

               SizedBox(height: sizeboxheight(context)*3),
                 GridView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                 itemCount: model.data.length,
                itemBuilder: (context, index) {
                  if (model.data.isNotEmpty){
                        return  MovieTile(result: model.data[index], genre: model.genre.toList(),);
                  }
                        return Container (
                            alignment: Alignment.center,
                            height: height(1,context),
                            width: width(1,context),
                            color: AppColors.white,
                            child: Center(
                              child: Text('NO MOVIES UPLOADED')
                            ),
                          );
                },
          )

    //               GridView.count(
    //   crossAxisCount: orientation ==Orientation.portrait ? 2 : 3,
    //   padding: EdgeInsets.all(4.0),
    //   childAspectRatio: 8.0 / 9.0,
    //   children: [

    //       Homebutton(
    //         genre: 'Romance',
    //         onpressed: (){

    //         },
    //       ),

    //        Homebutton(
    //         genre: 'Action',
    //         onpressed: (){

    //         },
    //       ),

    //        Homebutton(
    //         genre: 'Comedy',
    //         onpressed: (){

    //         },
    //       ),

    //        Homebutton(
    //         genre: 'Drama',
    //         onpressed: (){

    //         },
    //       ),

    //        Homebutton(
    //         genre: 'Fantasy',
    //         onpressed: (){

    //         },
    //       ),

    //        Homebutton(
    //         genre: 'Horror',
    //         onpressed: (){

    //         },
    //       ),

    //   ],
    // )
                ]),
              ));
        });
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_mart/ui/widget/generalButton.dart';
import 'package:movie_mart/utils/constants/colors.dart';
import 'package:movie_mart/utils/constants/screensize.dart';
import 'package:movie_mart/utils/constants/textstyle.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'movie_item_view_moel.dart';



// ignore: must_be_immutable
class MovieItem extends StatelessWidget {
  String title, imageUrl, description;
  int price;
  List eachGenre;
  DateTime releaseDate;
  MovieItem({this.description, this.eachGenre, this.imageUrl, this.price, this.releaseDate, this.title});
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<MovieReportViewModel>.withConsumer(
        viewModelBuilder: () => MovieReportViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: AppColors.secondaryColor,
              leading: GestureDetector( 
                onTap: () {
                  model.pop();
                },
                child: Icon(
                  Icons.arrow_back_ios_outlined,
                  color: AppColors.primaryColor,
                ),
              ),
              title: Text(
                title,
                style: appBartextStyle,
              ),
              centerTitle: true,
              elevation: 0,
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
            ),

          body: Stack(
            children: [
              Container(
                child: Column(
                  children: [
                      ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
                    child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        width: width(0.8, context),
                        height: height(0.5, context),
                        fit: BoxFit.cover),
                  ),

                  SizedBox(height:20),
                  Row(
                                 children: [
                                    Text('PRICE', style:TextStyle(fontSize: 20, color:AppColors.grey_light)),
                                    SizedBox(width:20),
                                    Text(price.toString(), style:TextStyle(fontSize: 40, color:AppColors.black))
                               ],),
                  SizedBox(height:10),

                  
                          Text( 'Year: ${releaseDate.toString()}',
                          style: TextStyle(
                            color: AppColors.red,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                   SizedBox(height:10),

                  Row(
                             children: eachGenre.map((entry) {
                           var w = Text(entry.toString(), style: TextStyle(color: Colors.black, fontSize: 17,));
                                   return w;
                            }).toList()
                           ),

                  SizedBox(height:20),
                  Text('Description', style:TextStyle(color: Colors.black, fontSize:25,)),
                   SizedBox(height:5),
                   Flexible(
                     child: Text(description, style:TextStyle(color: Colors.black, fontSize:20,)),
                   )
                  ],       
                ),
              ),


              Container(
                child: Align(alignment: Alignment.bottomCenter,
                child: CustomButton(
                  child:Text('ADD', style:TextStyle(color: Colors.white, fontSize:25,)),
                  onPressed: (){
                     model.addMovieTocart(imageUrl, price, title, releaseDate, eachGenre, context);              
                     model.setCartValue();
                  },
                ),
                ),
              )
            ],
          ),
          );
        }
    );
  }
}
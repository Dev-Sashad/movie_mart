
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_mart/core/model/genre_model.dart';
import 'package:movie_mart/core/model/movie_model.dart';
import 'package:movie_mart/ui/screens/home/dashboard/dashboard_view_model.dart';
import 'package:movie_mart/ui/screens/otherViews/movie_item_view/movie_item_view.dart';
import 'package:movie_mart/utils/constants/colors.dart';
import 'package:movie_mart/utils/constants/screensize.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';


// ignore: must_be_immutable
class MovieTile extends StatelessWidget {
  Results result;
  List<Genres> genre;
  double cwidth, cheight, iwidth, iheight;
  final int price= Random().nextInt(20)*15;
  MovieTile({ 
    this.result,
    this.genre,
    this.cwidth=0.35,
    this.cheight=0.3,
    this.iwidth=0.35,
    this.iheight=0.18
  });

  @override
  Widget build(BuildContext context) {
   String imageUrl = "image.tmdb.org"+ "/t/p/w500${result.backdropPath}";
   var genreName= genre.where((element) => result.genreIds[0] == element.id);
   List eachGenre= [
     genreName.map((e) => e.name).toList()
   ];
    return ViewModelProvider<DashboardViewModel>.withConsumer(
        viewModelBuilder: () => DashboardViewModel(),
        builder: (context, model, child) {
    return  GestureDetector(
      key : ValueKey(result.id),
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>MovieItem(
          description: result.overview,
          eachGenre: eachGenre,
          imageUrl: imageUrl,
          price: price,
          releaseDate: result.releaseDate,
          title: result.title,
        )));
      },
      child: Container(         
            margin: EdgeInsets.only(right: 15),
            width: width(cwidth, context),
            height: height(cheight, context),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius:4,
                  color:Colors.black12
                )
              ]
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
                  child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      width: width(iwidth, context),
                      height: height(iheight, context),
                      fit: BoxFit.cover),
                ),
                
                      SizedBox(height: sizeboxheight(context)*2),
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
              
                       Text(
                        result.title,
                        style: TextStyle(
                          color: AppColors.red,
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                         Row(
                           children: eachGenre.map((entry) {
                         var w = Text(entry.toString(), style: TextStyle(color: Colors.black, fontSize: 12,));
                                 return w;
                          }).toList()
                         ),

                        Text( 'Year: ${result.releaseDate.toString()}',
                        style: TextStyle(
                          color: AppColors.red,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    

                         Row(
                           children: [
                             Column(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                  Text('PRICE', style:TextStyle(fontSize: 20, color:AppColors.grey_light)),
                                  Text(price.toString(), style:TextStyle(fontSize: 20, color:AppColors.black))
                             ],),

                             TextButton(onPressed: (){
                                model.addMovieTocart(imageUrl, price, result.title, result.releaseDate, eachGenre, context);              
                                model.setCartValue();
                              

                              //  if(isAdded== true){
                              //   model.removeItem();
                              //  }
                             },
                             style: TextButton.styleFrom(
                               backgroundColor: AppColors.themeGreen,
                               shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(6),
                             )
                             ),
                              child:Text(
                               'ADD CART'
                             )                          
                              )
                           ],
                         )

                         

                    ],
                  ),
                )
              ],
            ),
          ),
    );
        }
    );
  }
}
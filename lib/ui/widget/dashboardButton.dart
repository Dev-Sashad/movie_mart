import 'package:flutter/material.dart';
import 'package:movie_mart/utils/constants/colors.dart';
import 'package:movie_mart/utils/constants/screensize.dart';

class Homebutton extends StatelessWidget {

final String genre;
 final Function onpressed;

 Homebutton ({this.genre,   this.onpressed});


  @override
  Widget build(BuildContext context) {
      return  TextButton(
        onPressed: onpressed,
        child: Container(
  height: height(0.2,context),
  width: width(0.35, context),
  decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(5),
  color: Colors.amber[100],
  boxShadow: [
    BoxShadow(
      blurRadius:4,
      color: Colors.black12
    )
  ]
  ),
  margin: EdgeInsets.symmetric(horizontal:10),
                  child: Text( genre,
                  style: TextStyle( 
                    fontSize: 15,
                    fontFamily: 'Caros',
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondaryColor,
                  ),
                ),          
                ),
      );

  }

}
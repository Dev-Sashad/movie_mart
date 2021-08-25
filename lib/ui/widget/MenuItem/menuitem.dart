import 'package:flutter/material.dart';
import 'package:movie_mart/utils/constants/colors.dart';

class MenuItem extends StatelessWidget {
final IconData icon;
final String title;
final Function onTap;

const MenuItem ({Key key, this.icon, this.title, this.onTap}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    onTap: onTap,
   child: Padding (
        padding: const EdgeInsets.all(15),

        child: Row(children: [
            Icon(
              icon,
              color: AppColors.white,
              size: 20,
            ),

            SizedBox(width:20),

            Text(
              title,

              style: TextStyle(fontWeight:FontWeight.w300, fontSize:20, color: AppColors.white),
            ),

                 SizedBox(width:10),

                   Divider(
                        color: AppColors.primaryColor.withOpacity(0.5),
                        height: 30,
                        thickness: 0.7,
                        indent: 10,
                        endIndent: 10,
                      ),

        ],),
    )
    );
  }


}
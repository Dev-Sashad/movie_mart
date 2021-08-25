import 'package:flutter/material.dart';
import 'package:movie_mart/utils/constants/colors.dart';
import 'package:movie_mart/utils/constants/textstyle.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'help_view_model.dart';



class Help extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<HelpViewModel>.withConsumer(
        viewModelBuilder: () => HelpViewModel(),
        builder: (context, model, child) {
          return Scaffold(  backgroundColor: AppColors.white,
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
                'Help',
                style: appBartextStyle,
              ),
              centerTitle: true,
              elevation: 0,
            ),

            body: Container(
            color: AppColors.white,
            padding: EdgeInsets.fromLTRB(53, 57, 55, 116),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                    Image.asset('assets/images/support.png', width:147, height:146),

                //  SizedBox(width:18),

                Row(
                 
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Image.asset('assets/images/social_support.png'),

                    // SizedBox(width:18),

                    Container(
                      padding: EdgeInsets.only(top:8),
                      //  alignment: Alignment.centerRight,
                      child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('https://facebook.com/moviemart', ),
                            SizedBox(height:47),
                            Text('https://instagram.com/moviemart', ),
                            SizedBox(height:54),
                            Text('https://twitter.com/moviemart',),
                            SizedBox(height:53),
                            Text('https://whatsapp.com/23588845882',),
                          ],
                      )
                    )
                  ]
                )
              ]
            )
          )
          );
        }
    );
  }
}
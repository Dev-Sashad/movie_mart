// import 'package:flutter/material.dart';
// import 'package:movie_mart/ui/widget/movie_tile.dart';
// import 'package:movie_mart/utils/constants/colors.dart';
// import 'package:movie_mart/utils/constants/screensize.dart';
// import 'package:movie_mart/utils/constants/textstyle.dart';
// import 'package:provider_architecture/provider_architecture.dart';
// import 'movie_list_view_model.dart';

// // ignore: must_be_immutable
// class MovieList extends StatelessWidget {
//   // String genre;
//   // MovieList({@required this.genre});
  
//   @override
//   Widget build(BuildContext context) {
//     return ViewModelProvider<MovieListViewModel>.withConsumer(
//         onModelReady: (e){
//           e.getMovies();
//           e.getGenres();
//         },
//         viewModelBuilder: () => MovieListViewModel(),
//         builder: (context, model, child) {
//           return 
          // Scaffold(
          //   extendBodyBehindAppBar: false,
          //   backgroundColor: AppColors.white,
            // appBar: AppBar(
            //   automaticallyImplyLeading: false,
            //   backgroundColor: AppColors.secondaryColor,
            //   leading: GestureDetector(
            //     onTap: () {},
            //     child: Icon(
            //       Icons.arrow_back_ios_outlined,
            //       color: AppColors.primaryColor,
            //     ),
            //   ),
            //   title: Text(
            //     'Movies',
            //     style: appBartextStyle,
            //   ),
            //   centerTitle: true,
            //   actions: <Widget>[
            //     TextButton(
            //       onPressed: () {},
            //       child: Stack(
            //         children: [
            //           Icon(
            //             (Icons.shopping_cart_outlined),
            //             color: AppColors.primaryColor,
            //           ),
            //           Positioned(
            //               right: -10,
            //               child: CircleAvatar(
            //                   backgroundColor: AppColors.white,
            //                   radius: 4,
            //                   child: Text(model.cartValue.toString(),
            //                       style: TextStyle(
            //                           color: AppColors.black, fontSize: 5)))),
            //         ],
            //       ),
            //     ),
            //   ],
            //   elevation: 0,
            // ),
            //body: 
//             GridView.builder(
//                 scrollDirection: Axis.vertical,
//                 shrinkWrap: true,
//                 gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//                  itemCount: model.data.length,
//                 itemBuilder: (context, index) {
//                   if (model.data.isNotEmpty){
//                         return  MovieTile(result: model.data[index], genre: model.genre.toList(),);
//                   }
//                         return Container (
//                             alignment: Alignment.center,
//                             height: height(1,context),
//                             width: width(1,context),
//                             color: AppColors.white,
//                             child: Center(
//                               child: Text('NO MOVIES UPLOADED')
//                             ),
//                           );
//                 },
//           );
//         });
//   }
// }



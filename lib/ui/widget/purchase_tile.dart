
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_mart/core/model/purchase_model.dart';
import 'package:movie_mart/utils/constants/colors.dart';
import 'package:movie_mart/utils/constants/screensize.dart';

// ignore: must_be_immutable
class PurchaseTile extends StatelessWidget {
  ListViewScreenModel model;
  Function delete;

  PurchaseTile(
      {this.model, this.delete,});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey<ListViewScreenModel>(model),
      margin: EdgeInsets.only(right: 15),
      width: width(0.35, context),
      height: height(0.3, context),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: AppColors.white,
          boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black12)]),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(6), topRight: Radius.circular(6)),
            child: CachedNetworkImage(
                imageUrl: model.image,
                width: width(0.35, context),
                height: height(0.18, context),
                fit: BoxFit.cover),
          ),
          SizedBox(height: sizeboxheight(context) * 2),
          Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  model.title,
                  style: TextStyle(
                    color: AppColors.red,
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                    children: model.genre.map((entry) {
                  var w = Text('${entry.value},',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ));
                  return w;
                }).toList()),
                Text(
                  'Year: ${model.year.toString()}',
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
                        Text('Price',
                            style: TextStyle(
                                fontSize: 20, color: AppColors.grey_light)),
                        Text(model.price.toString(),
                            style:
                                TextStyle(fontSize: 20, color: AppColors.black))
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Quantity',
                            style: TextStyle(
                                fontSize: 20, color: AppColors.grey_light)),
                        Text(model.quantity.toString(),
                            style:
                                TextStyle(fontSize: 20, color: AppColors.black))
                      ],
                    ),
                    Text(model.purchaseDate.toString(),
                        style: TextStyle(fontSize: 20, color: AppColors.black)),
                    TextButton(
                        onPressed: delete,
                        style: TextButton.styleFrom(
                            backgroundColor: AppColors.themeGreen,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            )),
                        child: Text('Delete'))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

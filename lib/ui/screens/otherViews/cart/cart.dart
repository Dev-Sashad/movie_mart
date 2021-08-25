import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_mart/ui/widget/generalButton.dart';
import 'package:movie_mart/utils/constants/colors.dart';
import 'package:movie_mart/utils/constants/screensize.dart';
import 'package:movie_mart/utils/constants/textstyle.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'cart_view_model.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  int newQuantity;
  int newPrice ;

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<CartViewModel>.withConsumer(
        viewModelBuilder: () => CartViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            extendBodyBehindAppBar: false,
            backgroundColor: AppColors.white,
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
                'My Cart',
                style: appBartextStyle,
              ),
              centerTitle: true,
              actions: <Widget>[
                Stack(
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
              ],
              elevation: 0,
            ),
            body: Stack(
              children: [
                Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total Price : ${model.price}'),
                          CustomButton(child: Text('PAY'), onPressed: () {})
                        ],
                      ),
                      Container(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            StreamBuilder<dynamic>(
                              stream: model.getCart(),
                              builder: (context, snapshot) {
                                if (snapshot.error || snapshot.data.docs.isEmpty) {
                                  return Container(
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'You have no item in your cart',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          SizedBox(
                                            height: sizeboxheight(context) * 2,
                                          ),
                                          TextButton(
                                              style: TextButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                backgroundColor: Colors.white,
                                              ),
                                              onPressed: () {
                                                model.navigateToHome();
                                              },
                                              child: Container(
                                                  child: Icon(
                                                      Icons.shopping_cart_outlined,
                                                      size: 30,
                                                      color: Colors.orangeAccent)))
                                        ],
                                      ));
                                } else {
                                  return AnimatedList(
                                      key: _listKey,
                                      initialItemCount: snapshot.data.length,
                                      itemBuilder: (context, i, animation) {
                                        var snap = snapshot.data.docs[i];
                                        model.price += snap.data()['price'];
                                        String documentId = snap.id;
                                        return FadeTransition(
                                          opacity: animation,
                                          child: _buildItem(
                                          context: context, 
                                          imageUrl: snap.data()['imageUrl'], 
                                          title: snap.data()['title'],
                                          genre: snap.data()['genre'].entries, 
                                          year: snap.data()['year'], 
                                          quantity: snap.data()['quantity'],
                                          price: snap.data()['price'], 
                                          onPress: (){
                                             model.deleteItem(snap.reference);
                                             model.animatedRemoveFromList(_listKey, snapshot, snap.data()['title'], _buildItem(title: snap.data()['title']));
                                          },
                                          update: model.increaseQuantiyPrice(documentId, newQuantity, newPrice)
                                          )
                                          
                                        );
                                      });
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                       Container(
                child: Align(alignment: Alignment.bottomCenter,
                child: CustomButton(
                  child:Text('PROCEED TO PAY', style:TextStyle(color: Colors.white, fontSize:25,)),
                  onPressed: (){
                    
                  },
                ),
                ),
              )
              ],
            ),
          );
        });
  }

  Widget _buildItem({BuildContext context, String imageUrl, String title , List genre, 
  int year, int quantity, int price, Function onPress, Function update()}){
                      newQuantity = quantity;
                      newPrice = price;
            
    return  Container(
      key: ValueKey(title),
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      width: width(0.7, context),
                                      height: height(0.3, context),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color: AppColors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 4,
                                                color: Colors.black12)
                                          ]),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(6),
                                                topRight: Radius.circular(6)),
                                            child: CachedNetworkImage(
                                                imageUrl:imageUrl,
                                                width: width(0.35, context),
                                                height: height(0.18, context),
                                                fit: BoxFit.cover),
                                          ),
                                          SizedBox(
                                              width:
                                                  sizeboxheight(context) * 2),
                                          Container(
                                            alignment: Alignment.center,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(title,
                                                  style: TextStyle(
                                                    color: AppColors.red,
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Row(
                                                    children: genre.map((entry) {
                                                  var w =
                                                      Text('${entry.value},',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12,
                                                          ));
                                                  return w;
                                                }).toList()),
                                                Text(
                                                  'Year: $year',
                                                  style: TextStyle(
                                                    color: AppColors.red,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),

                                      Row(children: [
                                         Text(
                                                  'Quantity',
                                                  style: TextStyle(
                                                    color: AppColors.red,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                          SizedBox(width: 20),

                                          Container(
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 5,
                                                  color: Colors.black12
                                                )
                                              ]
                                            ),
                                      child: IconButton(
                                        icon: Icon(Icons.add, size:20),
                                        onPressed: (){
                                          setState(() {
                                          int value = newPrice~/newQuantity;
                                          newQuantity = newQuantity++;
                                          newPrice= value*newQuantity;                                         
                                       });
                                          update();
                                        },
                                      ),
                                          ),

                                      SizedBox(width: 10),

                                    Text(newQuantity.toString(),
                                                  style: TextStyle(
                                                    color: AppColors.red,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),

                                     SizedBox(width: 10),

                                          Container(
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 5,
                                                  color: Colors.black12
                                                )
                                              ]
                                            ),
                                      child: IconButton(
                                        icon: Icon(Icons.remove, size:20),
                                        onPressed: (){
                                          setState(() {
                                                 int value = newPrice~/newQuantity;
                                          newQuantity = newQuantity--;
                                          newPrice = value*newQuantity;                                      
                                            });
                                          update();
                                        },
                                      ),
                                          ),

                                      ],),

                                                Row(
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text('PRICE',
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                color: AppColors
                                                                    .grey_light)),
                                                        Text(
                                                            newPrice.toString(),
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                color: AppColors
                                                                    .black))
                                                      ],
                                                    ),
                                                    TextButton(
                                                        onPressed: onPress,
                                                        style: TextButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    AppColors
                                                                        .themeGreen,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              6),
                                                                )),
                                                        child: Text('REMOVE'))
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

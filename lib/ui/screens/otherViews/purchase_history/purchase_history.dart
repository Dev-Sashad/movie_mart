import 'package:flutter/material.dart';
import 'package:movie_mart/ui/widget/purchase_tile.dart';
import 'package:movie_mart/utils/constants/colors.dart';
import 'package:movie_mart/utils/constants/screensize.dart';
import 'package:movie_mart/utils/constants/textstyle.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'purchase_history_view_model.dart';

class PurchaseHistory extends StatelessWidget {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<PurchaseHistoryViewModel>.withConsumer(
        onModelReady: (v) {
          v.getScreens();
        },
        viewModelBuilder: () => PurchaseHistoryViewModel(),
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
                  'Purchase History',
                  style: appBartextStyle,
                ),
                centerTitle: true,
                elevation: 0,
              ),
              body: Container(
                  alignment: Alignment.center,
                  height: height(1, context),
                  width: width(1, context),
                  child: model.screens == null
                      ? Container(
                          alignment: Alignment.center,
                          child: Text(
                            'You have purchase',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                          ),
                        )
                      : AnimatedList(
                          key: _listKey,
                          initialItemCount: model.screens.length,
                          itemBuilder: (context, i, animation) {
                            return FadeTransition(
                              opacity: animation,
                              child: PurchaseTile(
                                model: model.screens[i],
                                delete:(){model.animatedRemoveFromList(_listKey, model.screens[i].title);},
                              ),
                            );
                          })));
        });
  }
}
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'addcard_view_model.dart';



class AddCard extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<AddCardViewModel>.withConsumer(
        viewModelBuilder: () => AddCardViewModel(),
        builder: (context, model, child) {
          return Scaffold(
          );
        }
    );
  }
}
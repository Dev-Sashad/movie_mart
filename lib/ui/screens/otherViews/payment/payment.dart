import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'payment_view_model.dart';



class Payment extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<PaymentViewModel>.withConsumer(
        viewModelBuilder: () => PaymentViewModel(),
        builder: (context, model, child) {
          return Scaffold(
          );
        }
    );
  }
}
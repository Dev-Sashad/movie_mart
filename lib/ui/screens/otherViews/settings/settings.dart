import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'settings_view_model.dart';



class Settings extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<SettingsViewModel>.withConsumer(
        viewModelBuilder: () => SettingsViewModel(),
        builder: (context, model, child) {
          return Scaffold(
          );
        }
    );
  }
}
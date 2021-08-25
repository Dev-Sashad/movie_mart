import 'package:flutter/material.dart';
import 'package:movie_mart/ui/screens/home/dashboard/dashboard.dart';
import 'package:movie_mart/ui/screens/home/sideNav/sideNav.dart';



class HomePage extends StatefulWidget {
@override
  HomePageState createState() => HomePageState();
} 

class HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
    
@override
Widget build(BuildContext context) {
return  Scaffold(
  backgroundColor: Colors.orange[400],
  body: Stack(
      children: <Widget>[
       SideNavpage(),
       Dashboard(),
      
      ]
  
  ),
  );
}
}

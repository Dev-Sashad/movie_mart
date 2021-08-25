import 'package:flutter/material.dart';
  
  width(value, BuildContext context)
  {
    return MediaQuery.of(context).size.width * value;
  }

 height(value, BuildContext context)
  {
    return MediaQuery.of(context).size.height * value;
  }



sizeboxheight(BuildContext context){
  return height(0.02,context);
}

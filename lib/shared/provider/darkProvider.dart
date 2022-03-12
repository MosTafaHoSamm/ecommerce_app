import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DarkProvider with ChangeNotifier{

  bool isDark=false;
  void changeDarkMode(){
    isDark=!isDark;
    notifyListeners();
  }


}
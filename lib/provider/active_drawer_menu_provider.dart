import 'package:flutter/material.dart';

import '../model/menu.dart';


class ActiveDrawerMenuProvider with ChangeNotifier {
  MenuType activeDrawerMenuType = MenuType.home;

  void setActiveDrawerMenu(MenuType activeDrawerMenuType) {
    this.activeDrawerMenuType = activeDrawerMenuType;
    notifyListeners();
  }
}

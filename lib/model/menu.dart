import 'package:flutter/material.dart';

class Menu {
  final MenuType menuType;
  final IconData? icon;

  Menu({required this.menuType, required this.icon});
}

enum MenuType {
  home,
  aboutUs,
  contactUs,
  blog,
  faq,
}

extension MenuTypeExt on MenuType {
  String get value {
    String value;
    switch (this) {
      case MenuType.home:
        value = "Home";
        break;
      case MenuType.aboutUs:
        value = "About us";
        break;
      case MenuType.contactUs:
        value = "Contact us";
        break;
      case MenuType.blog:
        value = "Blogs";
        break;
      case MenuType.faq:
        value = "Frequently asked questions";
        break;
    }
    return value;
  }
}

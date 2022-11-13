import 'package:flutter/material.dart';
import 'package:nasa_educational_consultancy/screen/map_screen.dart';
import 'package:provider/provider.dart';

import '../model/menu.dart';
import '../provider/active_drawer_menu_provider.dart';
import '../widgets/app_bottom_navigation_bar.dart';
import 'about_us_screen.dart';
import 'blog_screen.dart';
import 'contact_us_screen.dart';
import 'faq_screen.dart';

class RootScreen extends StatelessWidget {
  static const String routeName = "/rootScreen";

  const RootScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MenuType selectedMenu =
        context.watch<ActiveDrawerMenuProvider>().activeDrawerMenuType;

    Widget page;
    switch (selectedMenu) {
      case MenuType.home:
        page = const BlogScreen();
        break;
      case MenuType.aboutUs:
        page = const AboutUsScreen();
        break;
      case MenuType.contactUs:
        page = const ContactUsScreen();
        break;
      case MenuType.blog:
        page = const BlogScreen();
        break;
      case MenuType.faq:
        page = const FaqScreen();
        break;
    }

    return Scaffold(
      body: page,
      bottomNavigationBar: const AppBottomNavigationBar(),
    );
  }
}

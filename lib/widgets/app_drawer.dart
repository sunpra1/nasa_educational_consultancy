import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/menu.dart';
import '../provider/active_drawer_menu_provider.dart';
import '../utils/app_theme.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Container(
          decoration: AppTheme.backgroundGradient,
          child: Column(
            children: const [
              AppDrawerBanner(),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 12.0,
                ),
                child: Divider(
                  color: Colors.black45,
                ),
              ),
              AppDrawerMenu(),
            ],
          ),
        ),
      ),
    );
  }
}

class AppDrawerBanner extends StatelessWidget {
  const AppDrawerBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 150,
      width: double.infinity,
    );
  }
}

class AppDrawerMenu extends StatelessWidget {
  const AppDrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Menu> drawerMenus = [
      Menu(
        menuType: MenuType.home,
        icon: Icons.home,
      ),
      Menu(
        menuType: MenuType.aboutUs,
        icon: Icons.info,
      ),
      Menu(
        menuType: MenuType.contactUs,
        icon: Icons.contact_phone,
      ),
      Menu(
        menuType: MenuType.blog,
        icon: Icons.newspaper,
      ),
      Menu(
        menuType: MenuType.faq,
        icon: Icons.question_answer_outlined,
      ),
    ];

    return Expanded(
      child: ListView.builder(
        itemBuilder: (_, index) => AppDrawerMenuItem(menu: drawerMenus[index]),
        itemCount: drawerMenus.length,
      ),
    );
  }
}

class AppDrawerMenuItem extends StatelessWidget {
  final Menu menu;

  const AppDrawerMenuItem({Key? key, required this.menu}) : super(key: key);

  void _handleOnAppDrawerMenuItemClick(BuildContext context) {
    context.read<ActiveDrawerMenuProvider>().setActiveDrawerMenu(menu.menuType);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    MenuType activeMenu =
        context.watch<ActiveDrawerMenuProvider>().activeDrawerMenuType;
    Color backGroundColor =
        activeMenu == menu.menuType ? Colors.black12 : Colors.transparent;

    return Material(
      color: backGroundColor,
      child: InkWell(
        onTap: () => _handleOnAppDrawerMenuItemClick(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                menu.icon,
                size: 16,
                color: Colors.white,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: Text(
                    menu.menuType.value,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

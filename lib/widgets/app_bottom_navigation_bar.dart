import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/menu.dart';
import '../provider/active_drawer_menu_provider.dart';
import '../utils/app_theme.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Menu> menus = [

    ];

    return Container(
      decoration: BoxDecoration(gradient: AppTheme.gradientLR),
      child: SizedBox(
        width: double.infinity,
        height: 64,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: menus.length,
          itemBuilder: (_, index) => AppBottomNavigationBarItem(
            menu: menus[index],
          ),
        ),
      ),
    );
  }
}

class AppBottomNavigationBarItem extends StatelessWidget {
  final Menu menu;

  const AppBottomNavigationBarItem({Key? key, required this.menu})
      : super(key: key);

  void _handleOnBottomNavigationMenuItemClick(BuildContext context) {
    context.read<ActiveDrawerMenuProvider>().setActiveDrawerMenu(menu.menuType);
  }

  @override
  Widget build(BuildContext context) {
    MenuType selectedMenu =
        context.watch<ActiveDrawerMenuProvider>().activeDrawerMenuType;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _handleOnBottomNavigationMenuItemClick(context),
        child: Container(
          color: menu.menuType == selectedMenu ? Colors.black26 : null,
          width: 80,
          height: 48,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 6.0,
              vertical: 12.0,
            ),
            child: Center(
              child: Column(
                children: [
                  Icon(
                    menu.icon,
                    color: Colors.white,
                    size: 18,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  FittedBox(
                    child: Text(
                      menu.menuType.value,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

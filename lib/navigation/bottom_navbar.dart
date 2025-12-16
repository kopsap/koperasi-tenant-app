import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:koperasitenantapp/themes/colors.dart';

/// Bottom navigation bar for the main app flow.
class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key, required this.child});

  final Widget child;

  /// List of navigation items with route names.
  List<_NavItem> _navItems(BuildContext context) => [
    _NavItem('', Icons.home, "Home"),
    _NavItem('stock', Icons.shopping_cart, "Barang"),
    _NavItem('order', Icons.attach_money, "Pesanan"),
  ];

  @override
  Widget build(BuildContext context) {
    final String currentLocation =
        GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;
    final int currentIndex = _navItems(
      context,
    ).indexWhere((item) => currentLocation == '/${item.route}');

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex == -1 ? 0 : currentIndex, // Default to Home
        backgroundColor: Colors.white,
        selectedIconTheme: IconThemeData(color: CustomColor.primaryColor),
        selectedItemColor: CustomColor.primaryColor,
        unselectedIconTheme: const IconThemeData(color: Color(0xFFD9D9D9)),
        unselectedItemColor: const Color(0xFFD9D9D9),
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          final newRoute = '/${_navItems(context)[index].route}';
          if (GoRouter.of(
                context,
              ).routerDelegate.currentConfiguration.fullPath !=
              newRoute) {
            GoRouter.of(context).go(newRoute);
          }
        },
        items:
            _navItems(context).map((item) {
              return BottomNavigationBarItem(
                icon: Icon(item.icon),
                label: item.label,
              );
            }).toList(),
      ),
    );
  }
}

/// Helper class to manage navigation items.
class _NavItem {
  final String route;
  final IconData icon;
  final String label;

  _NavItem(this.route, this.icon, this.label);
}

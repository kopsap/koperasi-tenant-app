import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:koperasitenantapp/navigation/bottom_navbar.dart';
import 'package:koperasitenantapp/screens/auth/auth_screen.dart';
import 'package:koperasitenantapp/screens/home/home_screen.dart';
import 'package:koperasitenantapp/screens/order/order_screen.dart';
import 'package:koperasitenantapp/screens/orderlist/orderlist_screen.dart';
import 'package:koperasitenantapp/screens/orderdetail/orderdetail_screen.dart';
import 'package:koperasitenantapp/screens/splash/splash_screen.dart';

GoRouter routes({
  required GlobalKey<NavigatorState> rootNavigatorKey,
  required GlobalKey<NavigatorState> shellNavigatorKey,
}) {
  return GoRouter(
    initialLocation: "/splash",
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: "/splash",
        name: "Splash",
        // Initial page it seems
        builder: (context, state) => SplashScreen(),
      ),
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        // Seems this is for navigation bar
        // builder: (context, state, child) => BottomNavBar(child: child),
        builder: (context, state, child) => Scaffold(body: child),
        routes: [
          // List main routes
          _authRoutes(rootNavigatorKey: rootNavigatorKey),
          _homeRoutes(rootNavigatorKey: rootNavigatorKey),
          // _orderRoutes(rootNavigatorKey: rootNavigatorKey),
        ],
      ),
    ],
  );
}

CustomTransitionPage<dynamic> _withScreenMiddleware(Widget screen) {
  return CustomTransitionPage(
    child: screen,
    transitionsBuilder:
        (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
  );
}

_authRoutes({required GlobalKey<NavigatorState> rootNavigatorKey}) {
  return GoRoute(
    path: "/auth/login",
    name: "authLogin",
    builder: (context, state) => AuthScreen(title: "Login Mitra KMS"),
  );
}

_homeRoutes({required GlobalKey<NavigatorState> rootNavigatorKey}) {
  return GoRoute(
    path: "/",
    name: "home",
    pageBuilder: (context, state) {
      return _withScreenMiddleware(HomeScreen(title: "Mitra KMS"));
    },
    routes: [
      _orderRoutes(rootNavigatorKey: rootNavigatorKey),
      _createOrderRoutes(rootNavigatorKey: rootNavigatorKey),
    ],
  );
}

_orderRoutes({required GlobalKey<NavigatorState> rootNavigatorKey}) {
  return GoRoute(
    parentNavigatorKey: rootNavigatorKey,
    path: "/order",
    name: "orderList",
    pageBuilder: (context, state) {
      return _withScreenMiddleware(OrderListScreen());
    },
    routes: [
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: "/detail",
        name: "orderDetail",
        builder: (context, state) {
          final intent = state.extra as Map;
          final orderCode = intent['orderCode'];
          final previous = intent['previous'];

          return OrderDetailScreen(orderCode: orderCode, extras: previous);
        },
      ),
    ],
  );
}

_createOrderRoutes({required GlobalKey<NavigatorState> rootNavigatorKey}) {
  return GoRoute(
    parentNavigatorKey: rootNavigatorKey,
    path: "/create",
    name: "order",
    builder: (context, state) {
      return OrderScreen();
    },
  );
}

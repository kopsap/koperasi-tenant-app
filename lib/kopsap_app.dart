import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:koperasitenantapp/navigation/routes.dart';
import 'package:koperasitenantapp/themes/colors.dart';
import 'package:koperasitenantapp/init/util/nfc.dart';

class KopsapApp extends StatefulWidget {
  const KopsapApp({super.key});

  @override
  State<KopsapApp> createState() => _KopsapAppState();
}

class _KopsapAppState extends State<KopsapApp> {
  // This widget is the root of your application.
  final navigatorKey = GlobalKey<NavigatorState>();
  final rootNavigatorKey = GlobalKey<NavigatorState>();
  late final GoRouter appRouter;

  @override
  void initState() {
    super.initState();
    appRouter = routes(
      rootNavigatorKey: rootNavigatorKey,
      shellNavigatorKey: navigatorKey,
    );

    initData();
  }

  void initData() {
    NFCReader.checkAvailability();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Tenant Koperasi Mitra Sentosa',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: CustomColor.primaryColor,
        cardTheme: CardThemeData(color: Colors.white),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(CustomColor.primaryColor),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
            ),
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: CustomColor.shadePrimaryColor,
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
          ),
          headlineSmall: TextStyle(
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
          ),
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.white,
        ),
      ),
      routeInformationParser: appRouter.routeInformationParser,
      routeInformationProvider: appRouter.routeInformationProvider,
      routerDelegate: appRouter.routerDelegate,
    );
  }
}

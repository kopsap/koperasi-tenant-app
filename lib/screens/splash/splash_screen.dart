import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:koperasitenantapp/themes/assets.dart';
import 'package:koperasitenantapp/themes/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int _counter = 3;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 1) {
          _counter--;
        } else {
          _timer?.cancel();
          context.goNamed("authLogin");
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.authBg),
          fit: BoxFit.cover,
          alignment: Alignment.center
        ),
      ),
      padding: EdgeInsets.all(40.0),
      child: Center(child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(40.0)),
              color: CustomColor.whiteColor,
            ),
            child: Image.asset(Assets.logo),
          ))));
  }
}

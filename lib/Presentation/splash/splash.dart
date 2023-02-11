import 'dart:async';
import 'package:advance_course/Presentation/resources/assets_manager.dart';
import 'package:advance_course/Presentation/resources/routes_manager.dart';
import 'package:advance_course/Presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  void initState() {
    super.initState();
    _delay();
  }

  _delay() {
    _timer = Timer(const Duration(seconds: 6), _navigate);
  }

  _navigate() {
    Navigator.pushReplacementNamed(context, Routes.onBourdingRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(AssetsManager.logoAsset, height: Appsize.s250),
      ),
    );
  }
}

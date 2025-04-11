import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ios_fl_n_crown_dream_3343/pages/navigate_screen.dart';
import 'package:ios_fl_n_crown_dream_3343/pages/onboarding_screen.dart';

class LaunchTracker {
  static final LaunchTracker _instance = LaunchTracker._privateConstructor();

  bool _wasLaunched = true;

  factory LaunchTracker() => _instance;

  LaunchTracker._privateConstructor();

  bool get isInitialLaunch => _wasLaunched;

  void markLaunchComplete() {
    _wasLaunched = false;
  }
}

class WelcomeSplashView extends StatefulWidget {
  const WelcomeSplashView({super.key});

  @override
  State<WelcomeSplashView> createState() => _WelcomeSplashViewState();
}

class _WelcomeSplashViewState extends State<WelcomeSplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _loadingBarController;

  @override
  void initState() {
    super.initState();
    _loadingBarController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();

    _startAppFlow();
  }

  void _startAppFlow() {
    final shouldShowIntro = LaunchTracker().isInitialLaunch;

    if (shouldShowIntro) {
      LaunchTracker().markLaunchComplete();
    }

    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              shouldShowIntro ? IntroScreen() : MainMenuScreen(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _loadingBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset('assets/images/splash.png', fit: BoxFit.fill),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ios_fl_n_crown_dream_3343/pages/navigate_screen.dart';

class IntroScreen extends StatefulWidget {
  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int _stepIndex = 0;

  final List<String> _backgroundImages = [
    'assets/images/onboard/1.png',
    'assets/images/onboard/2.png',
    'assets/images/onboard/3.png',
    'assets/images/onboard/4.png',
    'assets/images/onboard/5.png',
    'assets/images/onboard/6.png',
    'assets/images/onboard/7.png',
  ];

  final List<String> _actionLabels = [
    "Next",
    "Next",
    "Next",
    "Next",
    "Next",
    "Next",
    "Start using",
  ];

  void _handleNextStep() {
    if (_stepIndex < _backgroundImages.length - 1) {
      setState(() {
        _stepIndex++;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainMenuScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(_backgroundImages[_stepIndex], fit: BoxFit.cover),
          Positioned(
            bottom: 25,
            left: 20,
            right: 20,
            child: GestureDetector(
              onTap: _handleNextStep,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xFFFFF0B0), Color(0xFFAD7942)],
                  ),
                ),
                child: Center(
                  child: Text(
                    _actionLabels[_stepIndex],
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF0F0F1B),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

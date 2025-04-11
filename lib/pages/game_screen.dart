// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final PageController _pageController = PageController();
  int _count = 0;
  int _timeLeft = 10;
  Timer? _timer;

  void _startGame() {
    setState(() {
      _count = 0;
      _timeLeft = 10;
    });

    _pageController.animateToPage(
      1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft == 1) {
        _timer?.cancel();
        _pageController.animateToPage(
          2,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        setState(() {
          _timeLeft--;
        });
      }
    });
  }

  void _restartGame() {
    _pageController.animateToPage(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _shareResult() {
    Share.share('I counted $_count sheep before falling asleep! 🐑😴');
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildStartTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "A game for sleeping",
          style: TextStyle(
            color: Color(0xFFAD7942),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Image.asset('assets/images/game_preview.png', fit: BoxFit.cover),
        const SizedBox(height: 20),
        const Text(
          'Rules: You need to keep an eye on the screen and click on the plus sign when you see one sheep and then another and so on until the time runs out.',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 100),
        GestureDetector(
          onTap: _startGame,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(
                colors: [Color(0xFFFFF0B0), Color(0xFFAD7942)],
              ),
            ),
            child: const Center(
              child: Text(
                'Start to play!',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF0F0F1B),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 100),
      ],
    );
  }

  Widget _buildGameTab() {
    return Column(
      children: [
        const Text(
          "A game for sleeping",
          style: TextStyle(
            color: Color(0xFFAD7942),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 60),
        const Text(
          "Remember the number of lambs!!!",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 40),
        Image.asset("assets/images/game_action.png"),
        const SizedBox(height: 40),
        Text(
          "Time left is $_timeLeft second",
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 10),
        LinearProgressIndicator(
          value: _timeLeft / 10,
          backgroundColor: Colors.white24,
          color: const Color(0xFFAD7942),
        ),
        const SizedBox(height: 30),
        const Text(
          "Quantity",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _count--;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFF0B0), Color(0xFFAD7942)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.remove, color: Colors.black),
              ),
            ),
            const SizedBox(width: 12),
            Container(
              width: 100,
              height: 60,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                color: const Color(0xFF5F472C),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFB17E47).withOpacity(0.5),
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  '$_count',
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () {
                setState(() {
                  _count++;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFF0B0), Color(0xFFAD7942)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.add, color: Colors.black),
              ),
            ),
          ],
        ),
        const SizedBox(height: 150),
      ],
    );
  }

  Widget _buildResultTab() {
    return Column(
      children: [
        const Text(
          "A game for sleeping",
          style: TextStyle(
            color: Color(0xFFAD7942),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 60),
        const Text(
          "Time is up!!!",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 40),
        Image.asset("assets/images/game_action_default.png"),
        const SizedBox(height: 40),
        const Text(
          "The sheep have been counted:",
          style: TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 12),
        Container(
          width: 100,
          height: 60,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            color: const Color(0xFF5F472C),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFB17E47).withOpacity(0.5),
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              '$_count',
              style: const TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
        ),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 250,
              child: GestureDetector(
                onTap: _restartGame,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFFF0B0), Color(0xFFAD7942)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      "Play again",
                      style: TextStyle(
                        color: Color(0xFF0F0F1B),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            IconButton(
              onPressed: _shareResult,
              icon: Image.asset(
                'assets/images/share_icons.png',
                width: 40,
                height: 40,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
        const SizedBox(height: 100),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(child: _buildStartTab()),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(child: _buildGameTab()),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(child: _buildResultTab()),
            ),
          ],
        ),
      ),
    );
  }
}

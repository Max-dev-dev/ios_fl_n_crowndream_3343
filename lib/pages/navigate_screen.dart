import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ios_fl_n_crown_dream_3343/pages/favourites_songs_screen.dart';
import 'package:ios_fl_n_crown_dream_3343/pages/game_screen.dart';
import 'package:ios_fl_n_crown_dream_3343/pages/sound_settings_screen.dart';
import 'package:ios_fl_n_crown_dream_3343/pages/stats_screen.dart';
import 'package:ios_fl_n_crown_dream_3343/pages/timer_screen.dart';

class MainMenuScreen extends StatefulWidget {
  final int initialIndex;

  const MainMenuScreen({super.key, this.initialIndex = 0});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  late int _activeTab;

  final List<Widget> _screens = [
    const TimerScreen(),
    SoundSettingsScreen(),
    FavoriteAudiosScreen(),
    const StatsScreen(),
    const GameScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _activeTab = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          _screens[_activeTab],
          Positioned(
            bottom: 40,
            left: 30,
            right: 30,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTabIcon(0, FontAwesomeIcons.clock),
                  _buildTabIcon(1, FontAwesomeIcons.volumeHigh),
                  _buildTabIcon(2, FontAwesomeIcons.solidBookmark),
                  _buildTabIcon(3, FontAwesomeIcons.chartSimple),
                  _buildTabIcon(4, FontAwesomeIcons.gamepad),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabIcon(int index, IconData icon) {
    final bool isSelected = _activeTab == index;

    return GestureDetector(
      onTap: () => setState(() => _activeTab = index),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border:
              isSelected
                  ? Border.all(color: Color(0xFFC0945B), width: 2)
                  : null,
        ),
        child: FaIcon(
          icon,
          size: 24,
          color: isSelected ? Color(0xFFC0945B) : Colors.white,
        ),
      ),
    );
  }
}

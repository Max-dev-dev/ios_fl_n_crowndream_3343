import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ios_fl_n_crown_dream_3343/cubit/favourite_audio_cubit.dart';
import 'package:ios_fl_n_crown_dream_3343/cubit/sleep_cubit.dart';
import 'package:ios_fl_n_crown_dream_3343/pages/splash_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SleepCubit()),
        BlocProvider(create: (context) => FavoriteAudioCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/images/background.png',
                  fit: BoxFit.cover,
                ),
              ),
              child ?? const SizedBox.shrink(),
            ],
          );
        },
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF000000),
            scrolledUnderElevation: 0,
          ),
          scaffoldBackgroundColor: const Color(0xFF000000),
        ),
        home: WelcomeSplashView(),
      ),
    );
  }
}

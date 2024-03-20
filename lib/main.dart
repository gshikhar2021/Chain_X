import 'package:chain_x/screens/Auth.dart';
import 'package:chain_x/screens/Shops.dart';
import 'package:chain_x/screens/bubble_chart.dart';
import 'package:chain_x/screens/payment.dart';
import 'package:chain_x/screens/sales_analysis.dart';
import 'package:chain_x/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChainX',
      home: SplashScreen(),
    );
  }
}

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nasa_educational_consultancy/provider/active_drawer_menu_provider.dart';
import 'package:nasa_educational_consultancy/screen/about_us_screen.dart';
import 'package:nasa_educational_consultancy/screen/blog_screen.dart';
import 'package:nasa_educational_consultancy/screen/contact_us_screen.dart';
import 'package:nasa_educational_consultancy/screen/faq_screen.dart';
import 'package:nasa_educational_consultancy/screen/map_screen.dart';
import 'package:nasa_educational_consultancy/screen/nasa_splash_screen.dart';
import 'package:nasa_educational_consultancy/screen/root_screen.dart';
import 'package:provider/provider.dart';

import 'provider/connectivity_provider.dart';
import 'utils/app_theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ConnectivityProvider()),
        ChangeNotifierProvider(create: (_) => ActiveDrawerMenuProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    super.dispose();
    _connectivitySubscription.cancel();
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on Exception {
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    Provider.of<ConnectivityProvider>(context, listen: false)
        .setConnectivityResult(result);
  }

  // This widget is the root of your application
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nasa Education Consultancy',
      theme: ThemeData(
        colorScheme: AppTheme.colorScheme,
        fontFamily: AppTheme.fontFamilyPoppins,
      ),
      home: const NasaSplashScreen(),
      routes: {
        RootScreen.routeName: (_) => const RootScreen(),
      },
    );
  }
}

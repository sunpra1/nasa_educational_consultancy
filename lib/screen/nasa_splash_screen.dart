import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class NasaSplashScreen extends StatefulWidget {
  static const String routeName = "/karnaliSplashScreen";

  const NasaSplashScreen({Key? key}) : super(key: key);

  @override
  State<NasaSplashScreen> createState() => _NasaSplashScreenState();
}

class _NasaSplashScreenState extends State<NasaSplashScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.5;

    return Scaffold(
      backgroundColor: HexColor("#F5F5F5"),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Image.asset("asset/image/ripple_background.png"),
            ),
            Transform.translate(
              offset: const Offset(0, -50),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "asset/image/nasa_logo.png",
                      height: width * 0.25,
                      width: width,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    SizedBox(
                      width: width * 0.125,
                      height: width * 0.125,
                      child: const CircularProgressIndicator(),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      //TODO
      // Navigator.of(context).pushReplacementNamed("");
    });
  }
}

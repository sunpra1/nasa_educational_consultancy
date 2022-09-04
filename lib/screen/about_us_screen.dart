import 'package:flutter/material.dart';

class AboutUsScreen extends StatefulWidget {
  static const String routeName = "/aboutUs";

  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            snap: false,
            floating: true,
            expandedHeight: MediaQuery.of(context).size.height * 0.33,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('ABOUT US'),
              background: Image.asset("asset/image/about_us.webp"),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: const Center(
                child: Text('ABOUT US GOES HERE'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
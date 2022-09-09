import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';

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
      drawer: const AppDrawer(),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            snap: false,
            floating: true,
            expandedHeight: MediaQuery.of(context).size.height * 0.33,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'ABOUT US',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: Colors.white),
              ),
              background: Stack(
                children: [
                  Container(
                    color: Colors.black54,
                  ),
                  SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: Image.asset("asset/image/about_us.webp"),
                  ),
                ],
              ),
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
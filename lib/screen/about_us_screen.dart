import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:nasa_educational_consultancy/data/pojo/about_us.dart';
import 'package:nasa_educational_consultancy/data/repository.dart';

import '../widgets/app_drawer.dart';
import '../widgets/no_data_available.dart';
import '../widgets/progress_dialog.dart';

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
      body: FutureBuilder<AboutUs?>(
        future: Repository.getAboutUs(),
        builder: (_, snapshot) {
          AboutUs? aboutUs = snapshot.data;

          return Stack(
            children: [
              CustomScrollView(
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
                    child: (snapshot.connectionState == ConnectionState.done &&
                            aboutUs == null)
                        ? const NoDataAvailable(message: "NO DATA AVAILABLE")
                        : (snapshot.connectionState == ConnectionState.done &&
                                aboutUs != null)
                            ? Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minWidth: double.infinity,
                                    minHeight:
                                        MediaQuery.of(context).size.height,
                                  ),
                                  child: Center(
                                    child: HtmlWidget(aboutUs.details),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                  ),
                ],
              ),
              if (snapshot.connectionState != ConnectionState.done)
                const ProgressDialog(message: "Loading"),
            ],
          );
        },
      ),
    );
  }
}
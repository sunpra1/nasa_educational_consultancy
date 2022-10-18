import 'package:flutter/material.dart';

import '../data/pojo/blog.dart';
import '../data/repository.dart';
import '../utils/api_request.dart';
import '../widgets/app_drawer.dart';
import '../widgets/progress_dialog.dart';
import 'package:intl/intl.dart';

class BlogScreen extends StatelessWidget {
  static const String routeName = "/blogScreen";

  const BlogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      body: FutureBuilder<List<Blog>?>(
        future: Repository.getBlogs(),
        builder: (_, snapshot) {
          List<Blog>? blogs = snapshot.data;

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
                        'BLOGS',
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
                            child: Image.asset(
                              "asset/image/blog.png",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (blogs != null && blogs.isNotEmpty)
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (_, int index) => Padding(
                          padding: EdgeInsets.only(
                            top: index == 0 ? 8.0 : 4.0,
                            left: 8.0,
                            right: 8.0,
                            bottom: index == blogs.length - 1 ? 8.0 : 4.0,
                          ),
                          child: BlogItem(
                            blog: blogs[index],
                          ),
                        ),
                        childCount: blogs.length,
                      ),
                    ),
                ],
              ),
              if (snapshot.connectionState != ConnectionState.done)
                const ProgressDialog(message: "Loading")
            ],
          );
        },
      ),
    );
  }
}

class BlogItem extends StatelessWidget {
  final Blog blog;

  const BlogItem({Key? key, required this.blog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double imageSize = MediaQuery.of(context).size.width * 0.25;

    int prefSubString = 85;
    int descLength = blog.shortDesc.length;
    bool isShortDescGreaterThenPrefSubStringSize = descLength > prefSubString;

    return Card(
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: SizedBox(
                height: imageSize,
                width: imageSize,
                child: (blog.imagePath != null)
                    ? Image.network(
                        "https://${APIRequest.baseUrl}${blog.imagePath}",
                        fit: BoxFit.cover,
                        loadingBuilder: (context, widget, loadingProgress) {
                          if (loadingProgress == null) return widget;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      )
                    : Image.asset("asset/image/faq.png"),
              ),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.tag,
                      size: 12,
                    ),
                    Text(
                      blog.tag ?? "NO TAG",
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: Colors.grey),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.calendar_today_outlined,
                      size: 12,
                    ),
                    Text(
                      DateFormat("dd MMM yyyy hh.mm aa").format(DateTime.parse(blog.createDate)),
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
                Text(
                  blog.title,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  isShortDescGreaterThenPrefSubStringSize
                      ? "${blog.shortDesc.substring(0, prefSubString - 1)}..."
                      : blog.shortDesc,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(
                      Icons.remove_red_eye_sharp,
                      size: 12,
                    ),
                    Text(
                      "NO VIEWS DETAILS",
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: Colors.grey),
                    )
                  ],
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}

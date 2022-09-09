import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';

class BlogScreen extends StatelessWidget {
  static const String routeName = "/blogScreen";

  const BlogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Blog> blogs = Blog.getBlogs();

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
    );
  }
}

class BlogItem extends StatelessWidget {
  final Blog blog;

  const BlogItem({Key? key, required this.blog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double imageSize = MediaQuery.of(context).size.width * 0.25;

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
                child: Image.asset(blog.image),
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
                      blog.tag,
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
                      blog.date,
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
                  blog.shortDesc,
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
                      blog.views,
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

class Blog {
  final String title;
  final String shortDesc;
  final String desc;
  final String image;
  final String date;
  final String tag;
  final String views;

  const Blog({
    required this.title,
    required this.shortDesc,
    required this.desc,
    required this.image,
    required this.date,
    required this.tag,
    required this.views,
  });

  static List<Blog> getBlogs() {
    return [
      const Blog(
        title: "This is title.",
        shortDesc: "This is short desc.",
        desc: "This is description that is supposed to be very long.",
        image: "asset/image/faq.png",
        date: "1991-11-24, 10:33 AM",
        tag: "USA",
        views: "18698",
      ),
      const Blog(
        title: "This is title.",
        shortDesc: "This is short desc.",
        desc: "This is description that is supposed to be very long.",
        image: "asset/image/faq.png",
        date: "1991-11-24, 10:33 AM",
        tag: "USA",
        views: "18698",
      )
    ];
  }
}

import 'blog.dart';
import 'faq.dart';

class BlogResponse {
  static const String blogListKey = "blogList";

  List<Blog> blogList;

  BlogResponse({required this.blogList});

  factory BlogResponse.fromJson(Map<String, dynamic> json) => BlogResponse(
        blogList: Blog.getListFromJson(json[blogListKey]),
      );
}

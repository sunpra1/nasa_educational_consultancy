import 'package:nasa_educational_consultancy/model/blog_type.dart';

class Blog {
  static const String blogIdKey = "blogId";
  static const String titleKey = "title";
  static const String urlKey = "url";
  static const String imageFileKey = "imageFile";
  static const String imagePathKey = "imagePath";
  static const String shortDescKey = "shortDesc";
  static const String tagKey = "tag";
  static const String categoryKey = "category";
  static const String keywordsKey = "keywords";
  static const String detailsKey = "details";
  static const String typeKey = "type";
  static const String createDateKey = "createDate";

  int blogId;
  String title;
  String url;
  String? imageFile;
  String? imagePath;
  String shortDesc;
  String? tag;
  String category;
  String? keywords;
  String? details;
  BlogType type;
  String createDate;

  Blog({
    required this.blogId,
    required this.title,
    required this.url,
    required this.imageFile,
    required this.imagePath,
    required this.shortDesc,
    required this.tag,
    required this.category,
    required this.keywords,
    required this.details,
    required this.type,
    required this.createDate
  });

  factory Blog.fromJson(Map<String, dynamic> json) =>
     Blog(
      blogId : json[blogIdKey],
      title : json[titleKey],
      url : json[urlKey],
      imageFile : json[imageFileKey],
      imagePath : json[imagePathKey],
      shortDesc : json[shortDescKey],
      tag : json[tagKey],
      category : json[categoryKey],
      keywords : json[keywordsKey],
      details : json[detailsKey],
      type : blogTypeValues.map[json[typeKey]] ?? BlogType.none,
      createDate : json[createDateKey],
    );

  static List<Blog> getListFromJson(List<dynamic> jsonList) =>
      jsonList.map((e) => Blog.fromJson(e)).toList();
}

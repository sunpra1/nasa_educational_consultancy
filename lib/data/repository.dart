import 'package:nasa_educational_consultancy/data/pojo/blog_response.dart';

import '../utils/api_request.dart';
import 'pojo/about_us.dart';
import 'pojo/api_response.dart';
import 'pojo/blog.dart';
import 'pojo/contact_us.dart';
import 'pojo/faq.dart';
import 'pojo/faq_response.dart';

class Repository {
  static Future<AboutUs> getAboutUs() async {
    dynamic response = await APIRequest(
      requestType: RequestType.get,
      requestEndPoint: RequestEndPoint.aboutUs,
    ).make();
    ApiResponse aboutUsResponse = ApiResponse.fromJson(response);
    return AboutUs.fromJson(aboutUsResponse.data);
  }

  static Future<ContactUs> getContactUs() async {
    dynamic response = await APIRequest(
      requestType: RequestType.get,
      requestEndPoint: RequestEndPoint.contactUs,
    ).make();
    ApiResponse aboutUsResponse = ApiResponse.fromJson(response);
    return ContactUs.fromJson(aboutUsResponse.data);
  }

  static Future<List<Faq>> getFaqs() async {
    dynamic response = await APIRequest(
      requestType: RequestType.get,
      requestEndPoint: RequestEndPoint.faq,
    ).make();
    ApiResponse aboutUsResponse = ApiResponse.fromJson(response);
    return FaqResponse.fromJson(aboutUsResponse.data).faqList;
  }

  static Future<List<Blog>> getBlogs() async {
    dynamic response = await APIRequest(
      requestType: RequestType.get,
      requestEndPoint: RequestEndPoint.faq,
    ).make();
    ApiResponse aboutUsResponse = ApiResponse.fromJson(response);
    return BlogResponse.fromJson(aboutUsResponse.data).blogList;
  }
}

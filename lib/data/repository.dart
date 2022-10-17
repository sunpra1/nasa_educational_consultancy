import 'package:nasa_educational_consultancy/data/pojo/about_us.dart';
import 'package:nasa_educational_consultancy/data/pojo/contact_us.dart';

import '../utils/api_request.dart';
import 'pojo/api_response.dart';

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
}

import 'faq.dart';

class FaqResponse {
  static const String blogListKey = "blogList";

  List<Faq> faqList;

  FaqResponse({required this.faqList});

  factory FaqResponse.fromJson(Map<String, dynamic> json) => FaqResponse(
        faqList: Faq.getListFromJson(json[blogListKey]),
      );
}

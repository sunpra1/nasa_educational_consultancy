class AboutUs {
  static const aboutUsIdKey = "aboutUsId";
  static const typeKey = "type";
  static const detailsKey = "details";

  final int aboutUsId;
  final String type;
  final String details;

  const AboutUs(
      {required this.aboutUsId, required this.type, required this.details});

  factory AboutUs.fromJson(Map<String, dynamic> json) => AboutUs(
        aboutUsId: json[aboutUsIdKey],
        type: json[typeKey],
        details: json[detailsKey],
      );
}

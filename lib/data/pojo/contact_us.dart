class ContactUs {
  static const companyIdKey = "companyId";
  static const supportNumberKey = "supportNumber";
  static const addressKey = "address";
  static const emailKey = "email";
  static const locationKey = "location";
  static const nameKey = "name";
  static const phoneNumberKey = "phoneNumber";
  static const cellNumberKey = "cellNumber";
  static const socialNumberKey = "socialNumber";
  static const faceBookKey = "faceBook";
  static const youtubeKey = "youtube";
  static const instagramKey = "instagram";
  static const twitterLinkKey = "twitterLink";
  static const supportEmailKey = "supportEmail";
  static const enquiryEmailKey = "inqueryEmail";
  static const linkedInKey = "linkedIn";
  static const googleMapKey = "googleMap";
  static const logoKey = "logo";

  final int companyId;
  final String supportNumber;
  final String address;
  final String email;
  final String location;
  final String name;
  final String phoneNumber;
  final String? cellNumber;
  final String? socialNumber;
  final String? faceBook;
  final String? youtube;
  final String? instagram;
  final String? twitterLink;
  final String? supportEmail;
  final String? enquiryEmail;
  final String? linkedIn;
  final String? googleMap;
  final String? logo;

  const ContactUs({
    required this.companyId,
    required this.supportNumber,
    required this.address,
    required this.email,
    required this.location,
    required this.name,
    required this.phoneNumber,
    required this.cellNumber,
    required this.socialNumber,
    required this.faceBook,
    required this.youtube,
    required this.instagram,
    required this.twitterLink,
    required this.supportEmail,
    required this.enquiryEmail,
    required this.linkedIn,
    required this.googleMap,
    required this.logo,
  });

  factory ContactUs.fromJson(Map<String, dynamic> json) {
    return ContactUs(
      companyId: json[companyIdKey],
      supportNumber: json[supportNumberKey],
      address: json[addressKey],
      email: json[emailKey],
      location: json[locationKey],
      name: json[nameKey],
      phoneNumber: json[phoneNumberKey],
      cellNumber: json[cellNumberKey],
      socialNumber: json[supportNumberKey],
      faceBook: json[faceBookKey],
      youtube: json[youtubeKey],
      instagram: json[instagramKey],
      twitterLink: json[twitterLinkKey],
      supportEmail: json[supportEmailKey],
      enquiryEmail: json[enquiryEmailKey],
      linkedIn: json[linkedInKey],
      googleMap: json[googleMapKey],
      logo: json[logoKey],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nasa_educational_consultancy/data/pojo/contact_us.dart';
import 'package:nasa_educational_consultancy/data/repository.dart';
import 'package:nasa_educational_consultancy/utils/app_theme.dart';
import 'package:nasa_educational_consultancy/utils/utils.dart';
import 'package:nasa_educational_consultancy/widgets/progress_dialog.dart';
import 'package:nasa_educational_consultancy/widgets/selectable_dialog.dart';
import 'package:nasa_educational_consultancy/widgets/social_dialog.dart';

import '../widgets/app_drawer.dart';

class ContactUsScreen extends StatefulWidget {
  static const String routeName = "contactUsScreen";

  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  String? mapLink;
  Map<SocialType, String> socialLinks = {};
  Map<String, String> emails = {};
  Map<String, String> contacts = {};

  void onContactIconClicked(ContactIntent contactIntent) {
    switch (contactIntent) {
      case ContactIntent.viewOnMap:
        if (mapLink != null) {
          Utils.openLink(context, mapLink!);
        }
        break;
      case ContactIntent.mail:
        showDialog(
          context: context,
          builder: (_) => SelectableDialog(
            title: "SELECT MAIL ADDRESS",
            items: emails,
            onItemClick: (item) {
              Utils.sendEmail(context, item.value);
            },
            onCloseClick: () {
              Navigator.of(context).pop();
            },
          ),
        );

        break;
      case ContactIntent.call:
        showDialog(
          context: context,
          builder: (_) => SelectableDialog(
            title: "SELECT PHONE NUMBER",
            items: contacts,
            onItemClick: (item) {
              Utils.makeCall(context, item.value);
            },
            onCloseClick: () {
              Navigator.of(context).pop();
            },
          ),
        );
        break;
      case ContactIntent.openLink:
        showDialog(
          context: context,
          builder: (_) => SocialDialog(
            title: "SELECT SOCIAL ADDRESS",
            items: socialLinks,
            onItemClick: (item) {
              Utils.openLink(context, item);
            },
            onCloseClick: () {
              Navigator.of(context).pop();
            },
          ),
        );

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const AppDrawer(),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: FutureBuilder<ContactUs?>(
          future: Repository.getContactUs(),
          builder: (_, snapshot) {
            ContactUs? contactUs = snapshot.data;

            if (contactUs != null) {
              mapLink = contactUs.googleMap;
              contacts["Phone Number"] = contactUs.phoneNumber;
              if (contactUs.cellNumber != null) {
                contacts["Cell Number"] = contactUs.cellNumber!;
              }

              if (contactUs.socialNumber != null) {
                contacts["Cell Number"] = contactUs.socialNumber!;
              }
              if (contactUs.enquiryEmail != null) {
                emails["Enquiry Email"] = contactUs.enquiryEmail!;
              }
              if (contactUs.enquiryEmail != null) {
                emails["Support Email"] = contactUs.supportEmail!;
              }

              if (contactUs.faceBook != null) {
                socialLinks[SocialType.facebook] = contactUs.faceBook!;
              }
              if (contactUs.instagram != null) {
                socialLinks[SocialType.instagram] = contactUs.instagram!;
              }
              if (contactUs.twitterLink != null) {
                socialLinks[SocialType.twitter] = contactUs.twitterLink!;
              }
              if (contactUs.linkedIn != null) {
                socialLinks[SocialType.linkedin] = contactUs.linkedIn!;
              }
            }

            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.33,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: Image.asset("asset/image/contact_us.png")
                                    .image,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                    spreadRadius: 12,
                                    blurRadius: 6,
                                    color: Colors.black,
                                    blurStyle: BlurStyle.outer,
                                    offset: Offset(0, 4))
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Spacer(),
                                if (contactUs != null)
                                  Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        gradient: AppTheme.gradientTBContactUs),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        if (mapLink != null)
                                          IconButton(
                                            onPressed: () =>
                                                onContactIconClicked(
                                                    ContactIntent.viewOnMap),
                                            icon: Icon(
                                              Icons.map_outlined,
                                              color: HexColor("#2c23a2"),
                                            ),
                                          ),
                                        if (socialLinks.isNotEmpty)
                                          IconButton(
                                            onPressed: () =>
                                                onContactIconClicked(
                                                    ContactIntent.openLink),
                                            icon: Icon(
                                              const FaIcon(
                                                      FontAwesomeIcons.chrome)
                                                  .icon,
                                              color: HexColor("#2c23a2"),
                                            ),
                                          ),
                                        if (emails.isNotEmpty)
                                          IconButton(
                                            onPressed: () =>
                                                onContactIconClicked(
                                                    ContactIntent.mail),
                                            icon: Icon(
                                              Icons.email,
                                              color: HexColor("#2c23a2"),
                                            ),
                                          ),
                                        if (contacts.isNotEmpty)
                                          IconButton(
                                            onPressed: () =>
                                                onContactIconClicked(
                                                    ContactIntent.call),
                                            icon: Icon(
                                              Icons.phone,
                                              color: HexColor("#2c23a2"),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: const Offset(0, -60),
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Card(
                            elevation: 8,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 16.0,
                                right: 16.0,
                                top: 16.0,
                              ),
                              child: Column(
                                children: [
                                  TextFormField(
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    decoration: InputDecoration(
                                      enabled: true,
                                      errorText: null,
                                      errorMaxLines: 2,
                                      filled: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 12),
                                      border: const UnderlineInputBorder(),
                                      isDense: true,
                                      fillColor: Colors.white,
                                      hintText: "Provide your name.",
                                      label: Text(
                                        "Your Name",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.person,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    onChanged: (value) {},
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  TextFormField(
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    decoration: InputDecoration(
                                      enabled: true,
                                      errorText: null,
                                      errorMaxLines: 2,
                                      filled: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 12),
                                      border: const UnderlineInputBorder(),
                                      isDense: true,
                                      fillColor: Colors.white,
                                      hintText: "Provide your email.",
                                      label: Text(
                                        "Your Email",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.email,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    onChanged: (value) {},
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  TextFormField(
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    decoration: InputDecoration(
                                      enabled: true,
                                      errorText: null,
                                      errorMaxLines: 2,
                                      filled: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 12),
                                      border: const UnderlineInputBorder(),
                                      isDense: true,
                                      fillColor: Colors.white,
                                      hintText: "What's your interest area?",
                                      label: Text(
                                        "Area Of Interest",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.star,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    onChanged: (value) {},
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  TextFormField(
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    decoration: InputDecoration(
                                      enabled: true,
                                      errorText: null,
                                      errorMaxLines: 2,
                                      filled: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 12),
                                      border: const UnderlineInputBorder(),
                                      isDense: true,
                                      fillColor: Colors.white,
                                      hintText:
                                          "What's your preferred country?",
                                      label: Text(
                                        "Preferred Country",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.map,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    textInputAction: TextInputAction.next,
                                    onChanged: (value) {},
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  TextFormField(
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    minLines: 5,
                                    maxLines: 5,
                                    decoration: InputDecoration(
                                      enabled: true,
                                      errorText: null,
                                      errorMaxLines: 2,
                                      filled: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 12),
                                      border: const UnderlineInputBorder(),
                                      isDense: true,
                                      fillColor: Colors.white,
                                      hintText: "Provide your message.",
                                      label: Text(
                                        "Message",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.message_sharp,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.search,
                                    onChanged: (value) {},
                                  ),
                                  Transform.translate(
                                    offset: const Offset(0, 24),
                                    child: Transform.rotate(
                                      angle: 12,
                                      child: const SizedBox(
                                        height: 52,
                                        width: 52,
                                        child: CircleAvatar(
                                          child: Center(
                                            child: Icon(Icons.send_sharp,
                                                size: 24),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                if (snapshot.connectionState != ConnectionState.done)
                  const ProgressDialog(message: "Loading")
              ],
            );
          },
        ),
      ),
    );
  }
}

enum ContactIntent { viewOnMap, mail, call, openLink }

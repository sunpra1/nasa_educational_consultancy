import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nasa_educational_consultancy/screen/map_screen.dart';
import 'package:nasa_educational_consultancy/utils/app_theme.dart';
import 'package:nasa_educational_consultancy/utils/utils.dart';
import 'package:nasa_educational_consultancy/widgets/selectable_dialog.dart';

class ContactUsScreen extends StatefulWidget {

  static const String routeName = "contactUsScreen";

  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  List<String> emails = ["sunpra12@gmail.com", "5unpr4@gmail.com"];
  List<String> contacts = ["9849147995", "9742468112"];

  void onContactIconClicked(ContactIntent contactIntent) {
    switch (contactIntent) {
      case ContactIntent.viewOnMap:
        Navigator.of(context).pushNamed(MapScreen.routeName);
        break;
      case ContactIntent.mail:
        showDialog(
          context: context,
          builder: (_) => SelectableDialog(
            title: "SELECT MAIL ADDRESS",
            items: emails,
            onItemClick: (item) {
              Utils.sendEmail(item);
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
              Utils.makeCall(item);
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
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Image.asset("asset/image/contact_us.png").image,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        spreadRadius: 12,
                        blurRadius: 6,
                        color: Colors.black,
                        blurStyle: BlurStyle.outer,
                        offset: Offset(0, 4)
                      )
                    ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Spacer(),
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10.0),
                              gradient: AppTheme.gradientTBContactUs),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () =>
                                    onContactIconClicked(ContactIntent.viewOnMap),
                                icon: Icon(
                                  Icons.map_outlined,
                                  color: HexColor("#2c23a2"),
                                ),
                              ),
                              IconButton(
                                onPressed: () =>
                                    onContactIconClicked(ContactIntent.mail),
                                icon: Icon(
                                  Icons.email,
                                  color: HexColor("#2c23a2"),
                                ),
                              ),
                              IconButton(
                                onPressed: () =>
                                    onContactIconClicked(ContactIntent.call),
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
                            style: Theme.of(context).textTheme.bodyMedium,
                            decoration: InputDecoration(
                              enabled: true,
                              errorText: null,
                              errorMaxLines: 2,
                              filled: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              border: const UnderlineInputBorder(),
                              isDense: true,
                              fillColor: Colors.white,
                              hintText: "Provide your name.",
                              label: Text(
                                "Your Name",
                                style: Theme.of(context).textTheme.bodyMedium,
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
                            style: Theme.of(context).textTheme.bodyMedium,
                            decoration: InputDecoration(
                              enabled: true,
                              errorText: null,
                              errorMaxLines: 2,
                              filled: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              border: const UnderlineInputBorder(),
                              isDense: true,
                              fillColor: Colors.white,
                              hintText: "Provide your email.",
                              label: Text(
                                "Your Email",
                                style: Theme.of(context).textTheme.bodyMedium,
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
                            style: Theme.of(context).textTheme.bodyMedium,
                            decoration: InputDecoration(
                              enabled: true,
                              errorText: null,
                              errorMaxLines: 2,
                              filled: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              border: const UnderlineInputBorder(),
                              isDense: true,
                              fillColor: Colors.white,
                              hintText: "What's your interest area?",
                              label: Text(
                                "Area Of Interest",
                                style: Theme.of(context).textTheme.bodyMedium,
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
                            style: Theme.of(context).textTheme.bodyMedium,
                            decoration: InputDecoration(
                              enabled: true,
                              errorText: null,
                              errorMaxLines: 2,
                              filled: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              border: const UnderlineInputBorder(),
                              isDense: true,
                              fillColor: Colors.white,
                              hintText: "What's your preferred country?",
                              label: Text(
                                "Preferred Country",
                                style: Theme.of(context).textTheme.bodyMedium,
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
                            style: Theme.of(context).textTheme.bodyMedium,
                            minLines: 5,
                            maxLines: 5,
                            decoration: InputDecoration(
                              enabled: true,
                              errorText: null,
                              errorMaxLines: 2,
                              filled: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              border: const UnderlineInputBorder(),
                              isDense: true,
                              fillColor: Colors.white,
                              hintText: "Provide your message.",
                              label: Text(
                                "Message",
                                style: Theme.of(context).textTheme.bodyMedium,
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
                                    child: Icon(Icons.send_sharp, size: 24),
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
      ),
    );
  }
}

enum ContactIntent { viewOnMap, mail, call }

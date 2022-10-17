import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

class SocialDialog extends StatelessWidget {
  static const String keyValue = "value";
  static const String keyLabel = "label";

  final String title;
  final void Function(String item) onItemClick;
  final void Function() onCloseClick;
  final Map<SocialType, String> items;
  final Widget? itemIcon;

  const SocialDialog(
      {Key? key,
      required this.title,
      required this.items,
      required this.onItemClick,
      required this.onCloseClick,
      this.itemIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.7,
              minWidth: MediaQuery.of(context).size.width * 0.9,
              maxWidth: MediaQuery.of(context).size.width * 0.9,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 48.0,
                      ),
                      Expanded(
                        child: Text(
                          title,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Transform.translate(
                        offset: const Offset(8, -16),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            canRequestFocus: false,
                            splashColor: Colors.red.shade400,
                            onTap: onCloseClick,
                            borderRadius: BorderRadius.circular(4.0),
                            child: const SizedBox(
                              width: 48.0,
                              height: 48.0,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.close),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (_, index) => SelectableItem(
                        item: items.entries.elementAt(index),
                        onClick: onItemClick,
                        showDivider: index < items.length - 1,
                      ),
                      itemCount: items.length,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SelectableItem extends StatelessWidget {
  final MapEntry<SocialType, String> item;
  final bool showDivider;
  final void Function(String item) onClick;
  final Widget? itemIcon;

  const SelectableItem(
      {Key? key,
      required this.item,
      required this.onClick,
      required this.showDivider,
      this.itemIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData? icon = item.key == SocialType.facebook
        ? const FaIcon(FontAwesomeIcons.facebook).icon
        : item.key == SocialType.instagram
        ? const FaIcon(FontAwesomeIcons.instagram).icon
        : item.key == SocialType.youtube
        ? const FaIcon(FontAwesomeIcons.youtube).icon
        : item.key == SocialType.twitter
        ? const FaIcon(FontAwesomeIcons.twitter).icon
        : const FaIcon(FontAwesomeIcons.linkedin).icon;

    String label = item.key == SocialType.facebook
        ? SocialType.facebook.name.toUpperCase()
        : item.key == SocialType.instagram
            ? SocialType.instagram.name.toUpperCase()
            : item.key == SocialType.youtube
                ? SocialType.youtube.name.toUpperCase()
                : item.key == SocialType.twitter
                    ? SocialType.twitter.name.toUpperCase()
                    : SocialType.linkedin.name.toUpperCase();

    Color color = item.key == SocialType.facebook
        ? HexColor("#1877f2")
        : item.key == SocialType.instagram
            ? HexColor("#c32aa3")
            : item.key == SocialType.youtube
                ? HexColor("#ff0000")
                : item.key == SocialType.twitter
                    ? HexColor("#1da1f2")
                    : HexColor("#0a66c2");

    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.red.shade400,
            borderRadius: BorderRadius.circular(4.0),
            onTap: () => onClick.call(item.value),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (itemIcon != null) itemIcon!,
                  if (itemIcon != null) const SizedBox(width: 4.0),
                  Expanded(
                    child: Transform.translate(
                      offset: const Offset(0, 3),
                      child: IconButton(
                        onPressed: () => onClick.call(item.value),
                        icon: Row(
                          children: [
                            Icon(
                              icon,
                              color: color,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                label,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(fontSize: 16, color: color),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (showDivider)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Divider(thickness: 1.0),
          ),
      ],
    );
  }
}

enum SocialType { facebook, youtube, instagram, twitter, linkedin }

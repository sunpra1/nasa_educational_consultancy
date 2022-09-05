import 'package:flutter/material.dart';
import 'package:nasa_educational_consultancy/utils/app_theme.dart';

class FaqScreen extends StatelessWidget {
  static const String routeName = "/faqScreen";

  const FaqScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<FAQ> faqs = FAQ.getSampleQuestion();

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            snap: false,
            floating: true,
            expandedHeight: MediaQuery.of(context).size.height * 0.33,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'FREQUENTLY ASKED QUESTIONS',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: Colors.white),
              ),
              background: Stack(
                children: [
                  Container(
                    color: Colors.black54,
                  ),
                  SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: Image.asset(
                      "asset/image/faq.png",
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, int index) => Padding(
                padding: EdgeInsets.only(
                  top: index == 0 ? 8.0 : 4.0,
                  left: 8.0,
                  right: 8.0,
                  bottom: index == faqs.length - 1 ? 8.0 : 4.0,
                ),
                child: FaqItem(
                  faq: faqs[index],
                ),
              ),
              childCount: faqs.length,
            ),
          ),
        ],
      ),
    );
  }
}

class FaqItem extends StatefulWidget {
  final FAQ faq;

  const FaqItem({Key? key, required this.faq}) : super(key: key);

  @override
  State<FaqItem> createState() => _FaqItemState();
}

class _FaqItemState extends State<FaqItem> {
  bool _isSelected = false;

  void _onSelected() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    int prefSubString = 85;
    int descLength = widget.faq.answer.length;
    bool shouldShowViewMore = descLength > 85 - 1;

    return Container(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: _onSelected,
        child: Card(
          elevation: 8,
          shadowColor: Colors.grey.shade400,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.faq.question,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const Divider(),
                        Text(
                          _isSelected ? widget.faq.answer : "${widget.faq.answer.substring(0, prefSubString - 1)}...",
                          maxLines: _isSelected ? null : 2,
                          softWrap: true,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        if (!_isSelected && shouldShowViewMore)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: _onSelected,
                                child: Text(
                                  "View more",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(color: Colors.blue),
                                ),
                              )
                            ],
                          )
                      ],
                    ),
                  ),
                ),
                _isSelected
                    ? const Icon(Icons.keyboard_arrow_down)
                    : const Icon(Icons.keyboard_arrow_right),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FAQ {
  final String question;
  final String answer;

  const FAQ(this.question, this.answer);

  static List<FAQ> getSampleQuestion() {
    return [
      const FAQ("What is the brain drop and what they do?",
          "Maecenas sapien erat, porta non porttitor non, dignissim et enim. Aenean ac tincidunt tortor sedelon bondMaecenas sapien erat, porta non porttitor non, dignissim et enim. Aenean ac tincidunt tortor sedelon bondMaecenas sapien erat, porta non porttitor non, dignissim et enim. Aenean ac tincidunt tortor sedelon bond,"),
      const FAQ("Recognizing The Need Is The Primary",
          "Maecenas sapien erat, porta non porttitor non, dignissim et enim. Aenean ac tincidunt tortor sedelon bondMaecenas sapien erat, porta non porttitor non, dignissim et enim. Aenean ac tincidunt tortor sedelon bondMaecenas sapien erat, porta non porttitor non, dignissim et enim. Aenean ac tincidunt tortor sedelon bond."),
      const FAQ("Recognizing The Need Is The Primary",
          "Maecenas sapien erat, porta non porttitor non, dignissim et enim. Aenean ac tincidunt tortor sedelon bondMaecenas sapien erat, porta non porttitor non, dignissim et enim. Aenean ac tincidunt tortor sedelon bondMaecenas sapien erat, porta non porttitor non, dignissim et enim. Aenean ac tincidunt tortor sedelon bond. Maecenas sapien erat, porta non porttitor non, dignissim et enim. Aenean ac tincidunt tortor sedelon bondMaecenas sapien erat, porta non porttitor non, dignissim et enim. Aenean ac tincidunt tortor sedelon bondMaecenas sapien erat, porta non porttitor non, dignissim et enim. Aenean ac tincidunt tortor sedelon bond.")
    ];
  }
}

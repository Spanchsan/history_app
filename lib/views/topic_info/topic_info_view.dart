import 'package:flutter/material.dart';
import 'package:history_app/core/utils.dart';
import 'package:history_app/routes/app_routes.dart';
import 'package:history_app/views/topic_info/topic_info_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class TopicInfoView extends StatefulWidget {
  final int? topicId;
  const TopicInfoView({super.key, this.topicId});

  @override
  State<StatefulWidget> createState() => TopicInfoState();
}

class TopicInfoState extends State<TopicInfoView> {
  TopicInfoController controller = TopicInfoController();
  String topicName = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Utils.getStandardAppBar('Topic', true, () {
        Navigator.pop(context);
      }),
      body: SafeArea(
          child: Container(
              width: double.infinity,
              padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 20, vertical: 10),
              child: FutureBuilder<dynamic>(
                future: controller.fetchTopicInfoData(widget.topicId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Widget> widgets = [];
                    // setting text styles based on different text formats
                    TextStyle textStyleTitle = const TextStyle(
                        fontSize: 38, fontWeight: FontWeight.bold, height: 1.2);
                    TextStyle textStyleText = const TextStyle(
                      fontSize: 20,
                      height: 1.1,
                    );
                    // adding widgets based on the received text
                    for (String row in snapshot.data) {
                      if (row.startsWith('***title***')) {
                        topicName = row.replaceAll('***title***', '');
                        widgets.add(Text(
                          row.replaceAll('***title***', ''),
                          style: textStyleTitle,
                          textAlign: TextAlign.center,
                        ));
                      } else if (row.startsWith("***image***")) {
                        widgets.add(
                          Container(
                              padding: const EdgeInsetsDirectional.symmetric(
                                  vertical: 10),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    row.replaceAll('***image***', ''),
                                    height: 150,
                                  ))),
                        );
                      } else if (row.startsWith("***button***")) {
                        var l_trow =
                            row.replaceAll('***button***', '').split('***');
                        widgets.add(Container(
                          padding: const EdgeInsetsDirectional.symmetric(
                              vertical: 20),
                          child: TextButton(
                            onPressed: () async {
                              final Uri url = Uri.parse(l_trow.last);
                              if (!await launchUrl(url)) {
                                throw Exception('Could not launch $url');
                              }
                            },
                            style: Utils.getStandardButtonStyle(
                                const Size(150, 60)),
                            child: Text(
                              l_trow.first,
                              style: const TextStyle(fontSize: 25),
                            ),
                          ),
                        ));
                      } else {
                        widgets.add(Container(
                            padding: const EdgeInsetsDirectional.symmetric(
                                vertical: 10),
                            child: Text(
                              row,
                              style: textStyleText,
                              textAlign: TextAlign.justify,
                            )));
                      }
                    }
                    widgets.add(TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.learn_more,
                            arguments: topicName);
                      },
                      style: Utils.getStandardButtonStyle(),
                      child: const Text(
                        textAlign: TextAlign.center,
                        'Ask questions to our AI instructor!',
                        style: TextStyle(fontSize: 25),
                      ),
                    ));
                    return SingleChildScrollView(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: widgets,
                    ));
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ))),
    );
  }
}

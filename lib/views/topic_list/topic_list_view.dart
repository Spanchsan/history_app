import 'package:flutter/material.dart';
import 'package:history_app/core/utils.dart';
import 'package:history_app/routes/app_routes.dart';
import 'package:history_app/views/topic_list/topic_list_controller.dart';

class TopicListView extends StatefulWidget {
  const TopicListView({super.key});

  @override
  State<StatefulWidget> createState() => TopicListState();
}

class TopicListState extends State<TopicListView> {
  List<List<String>> topicTitles = [];
  final controller = TopicListController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Utils.getStandardAppBar('Topics', true, () {
          Navigator.pop(context);
        }),
        body: Center(
            child: FutureBuilder<dynamic>(
          future: controller.getTopicData(),
          builder: (context, snapshot) {
            // get the data
            if (snapshot.hasData) {
              topicTitles = snapshot.data; // get titles
              return ListView.builder(
                  //create list views
                  itemCount: topicTitles[0].length,
                  itemBuilder: (context, index) {
                    return Card(
                        color: Utils.getMaterialColor(
                            const Color.fromRGBO(232, 195, 176, 0.8)),
                        child: ListTile(
                          leading: const Icon(Icons.info_rounded),
                          title: Text(
                            topicTitles[0][index],
                          ),
                          titleTextStyle: const TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          subtitle: Text(
                            topicTitles[1][index],
                          ),
                          subtitleTextStyle: const TextStyle(
                              fontSize: 20,
                              color: Colors.brown,
                              fontStyle: FontStyle.italic),
                          onTap: () {
                            // goto Topic Info
                            Navigator.pushNamed(context, AppRoutes.topicInfo,
                                arguments: index);
                          },
                        ));
                  });
            }
            return const CircularProgressIndicator();
          },
        )));
  }
}

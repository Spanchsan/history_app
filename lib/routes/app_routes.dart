// lib/routes/app_routes.dart

import 'package:flutter/material.dart';
import 'package:history_app/views/learn_more_gpt/learn_more_gpt_view.dart';
import 'package:history_app/views/topic_info/topic_info_view.dart';
import 'package:history_app/views/topic_list/topic_list_view.dart';
import 'package:history_app/views/topic_test/topic_test_view.dart';
import 'package:history_app/views/welcome/welcome_view.dart';

class AppRoutes {
  static const String welcome = '/welcome';
  static const String topicList = '/topic_list';
  static const String home = '/';
  static const String topicInfo = '/topic_info';
  static const String topicTest = '/topic_test';
  static const String learn_more = '/learn_more';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const WelcomeView());
      case welcome:
        return MaterialPageRoute(builder: (_) => const WelcomeView());
      case topicList:
        return MaterialPageRoute(builder: (_) => const TopicListView());
      case topicInfo:
        final topicId = settings.arguments as int?;
        return MaterialPageRoute(
            builder: (_) => TopicInfoView(topicId: topicId));
      case topicTest:
        final topicId = settings.arguments as int?;
        return MaterialPageRoute(
            builder: (_) => TopicTestView(topicId: topicId));
      case learn_more:
        final String? topicName = settings.arguments as String?;
        return MaterialPageRoute(
            builder: (_) => LearnMoreGptView(topicName: topicName));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}

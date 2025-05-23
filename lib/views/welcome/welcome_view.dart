import 'package:flutter/material.dart';
import 'package:history_app/core/utils.dart';
import 'package:history_app/routes/app_routes.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Utils.getStandardAppBar('History app', false),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 300),
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: const Image(
                  image: AssetImage('assets/logomain.jpg'),
                  height: 150,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                constraints: const BoxConstraints(maxWidth: 280),
                child: const Text(
                  'Learn History with us',
                  style: TextStyle(
                      fontSize: 35, fontWeight: FontWeight.bold, height: 1.2),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                constraints: const BoxConstraints(maxWidth: 250),
                child: const Text(
                  'Learn several topics and test yourself in our application!',
                  style: TextStyle(fontSize: 20, color: Colors.blueGrey),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.topicList);
                },
                icon: const Icon(Icons.info_outline),
                style: Utils.getStandardButtonStyle(),
                label: const Text(
                  'Learn',
                  style: TextStyle(fontSize: 22),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.topicTest);
                },
                icon: const Icon(Icons.question_mark_outlined),
                style: Utils.getStandardButtonStyle(),
                label: const Text(
                  'Test',
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

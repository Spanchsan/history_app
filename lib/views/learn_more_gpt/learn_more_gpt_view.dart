/*
Program retrieved from GeeksForGeeks.
Link: https://www.geeksforgeeks.org/how-to-create-a-chatbot-application-using-chatgpt-api-in-flutter/

 */

import 'dart:convert';

import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:flutter/material.dart';
import 'package:history_app/core/utils.dart';
import 'package:http/http.dart' as http;

// ChatScreen widget to display a chatbot interface
class LearnMoreGptView extends StatefulWidget {
  final String? topicName;
  const LearnMoreGptView({super.key, this.topicName});

  @override
  State<LearnMoreGptView> createState() => LearnMoreGptState();
}

class LearnMoreGptState extends State<LearnMoreGptView> {
  // Controllers for text input and scrolling
  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();

  // List to store chat messages
  List<Message> msgs = [];

  // Tracks if the bot is typing
  bool isTyping = false;

  // Function to send a message and get a response from OpenAI API
  void sendMsg() async {
    String text = controller.text;
    String apiKey = "your API token"; // Replace with your OpenAI API key
    controller.clear();

    try {
      if (text.isNotEmpty) {
        // Add user message to the list and show typing indicator
        setState(() {
          msgs.insert(0, Message(true, text));
          isTyping = true;
        });

        // Scroll to the top of the chat
        scrollController.animateTo(
          0.0,
          duration: const Duration(seconds: 1),
          curve: Curves.easeOut,
        );

        // Send the message to OpenAI API
        var response = await http.post(
          Uri.parse("https://api.openai.com/v1/chat/completions"),
          headers: {
            "Authorization": "Bearer $apiKey",
            "Content-Type": "application/json"
          },
          body: jsonEncode({
            "model": "gpt-4.1-nano",
            "messages": [
              {
                "role": "developer",
                "content":
                    "Be a history teacher that will answer questions for given topic: ${widget.topicName} of Kazakh history"
              },
              {"role": "user", "content": text}
            ]
          }),
        );

        print(response.body);

        // Handle API response
        if (response.statusCode == 200) {
          var json = jsonDecode(response.body);
          setState(() {
            isTyping = false;
            msgs.insert(
              0,
              Message(
                false,
                json["choices"][0]["message"]["content"].toString().trimLeft(),
              ),
            );
          });

          // Scroll to the top of the chat
          scrollController.animateTo(
            0.0,
            duration: const Duration(seconds: 1),
            curve: Curves.easeOut,
          );
        }
      }
    } on Exception {
      // Show error message if API call fails
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Some error occurred, please try again!"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Utils.getStandardAppBar('Learn More!', true, () {
        Navigator.pop(context);
      }),
      body: Column(
        children: [
          Container(
              padding: EdgeInsetsDirectional.all(10),
              child: Text(
                widget.topicName!,
                style: const TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              )),
          const SizedBox(height: 8),
          // Chat messages list
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: msgs.length,
              shrinkWrap: true,
              reverse: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: isTyping && index == 0
                      ? Column(
                          children: [
                            BubbleNormal(
                              text: msgs[0].msg,
                              isSender: true,
                              color: Colors.blue.shade100,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 16, top: 4),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Typing..."),
                              ),
                            )
                          ],
                        )
                      : BubbleNormal(
                          text: msgs[index].msg,
                          isSender: msgs[index].isSender,
                          color: msgs[index].isSender
                              ? Colors.blue.shade100
                              : Colors.grey.shade200,
                        ),
                );
              },
            ),
          ),
          // Input field and send button
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: TextField(
                        controller: controller,
                        textCapitalization: TextCapitalization.sentences,
                        onSubmitted: (value) {
                          sendMsg();
                        },
                        textInputAction: TextInputAction.send,
                        showCursor: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Ask question",
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  sendMsg();
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }
}

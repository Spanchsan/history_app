import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:history_app/core/utils.dart';
import 'package:history_app/views/topic_test/topic_test_controller.dart';

class TopicTestView extends StatefulWidget {
  final int? topicId;
  const TopicTestView({super.key, this.topicId});
  @override
  State<StatefulWidget> createState() => TopicTestState();
}

class TopicTestState extends State<TopicTestView> {
  TopicTestController controller = TopicTestController();
  int qIndex = 0, qMax = 1;
  late Future<List<Question>> futureQuestions;
  int selectedAnswerIndex = -1;
  bool isCorrectAnswer = false;
  int topicId = -1;

  @override
  void initState() {
    super.initState();
    if (widget.topicId == null) {
      topicId = -1;
    } else {
      topicId = widget.topicId!;
    }
    futureQuestions = controller.fetchQuestion(topicId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Utils.getStandardAppBar('Test yourself!', true, () {
          Navigator.pop(context);
        }),
        body: Container(
          padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 20, vertical: 10),
          child: FutureBuilder<List<Question>>(
            future: futureQuestions,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                qMax = snapshot.data!.length;
                Question qs = snapshot.data![qIndex];
                return SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      qs.question,
                      style: const TextStyle(fontSize: 25),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    IntrinsicHeight(
                        child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                            //button 0
                            child: createTestButton(0, qs)),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                            // button 1
                            child: createTestButton(1, qs))
                      ],
                    )),
                    const SizedBox(
                      height: 10,
                    ),
                    IntrinsicHeight(
                        child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                            //button 2
                            child: createTestButton(2, qs)),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                            // button 3
                            child: createTestButton(3, qs))
                      ],
                    )),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          if (qIndex < qMax - 1) {
                            selectedAnswerIndex = -1;
                            qIndex++;
                          } else {
                            Utils.showSnackBar(context, 'No more questions!');
                          }
                        });
                      },
                      style: Utils.getStandardButtonStyle(),
                      child: const Text(
                        'Next Question',
                        style: TextStyle(fontSize: 30),
                      ),
                    )
                  ],
                ));
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ));
  }

  TextButton createTestButton(int index, Question qs) {
    return TextButton(
      onPressed: () {
        setState(() {
          selectedAnswerIndex = index;
          isCorrectAnswer = qs.corAnsId - 1 == index;
          if (isCorrectAnswer) {
            HapticFeedback.lightImpact();
            Utils.showSnackBar(context, 'Correct Answer!');
          } else {
            HapticFeedback.heavyImpact();
            Utils.showSnackBar(context, 'Incorrect Answer!');
          }
        });
      },
      style: Utils.getStandardButtonStyle(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            // This stretches text to fill vertical space
            child: Center(
              child: Text(
                qs.answers[index],
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
                maxLines: null, // allow wrapping
                overflow: TextOverflow.visible,
              ),
            ),
          ),
          if (selectedAnswerIndex == index)
            Icon(
              isCorrectAnswer ? Icons.check : Icons.close,
              color: Colors.white,
              size: 28,
            ),
        ],
      ),
    );
  }
}

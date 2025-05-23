import 'package:excel/excel.dart';
import 'package:flutter/services.dart';
import 'package:history_app/core/utils.dart';

class TopicTestController {
  Future<List<Question>> fetchQuestion([int topicId = 0]) async {
    ByteData bytes = await rootBundle.load('assets/topics.xlsx');
    List<int> bytList =
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
    var excel = Excel.decodeBytes(bytList);

    List<Question> data = [];

    Sheet table = excel.tables['Questions']!;
    for (int row = 0; row < 13; row++) {
      if (topicId == -1 ||
          int.parse(table
                  .cell(
                      CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: row))
                  .value
                  .toString()) ==
              topicId) {
        Question question = Question(
            table
                .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row))
                .value
                .toString(),
            table
                .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: row))
                .value
                .toString()
                .split('***'),
            int.parse(table
                .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: row))
                .value
                .toString()));
        data.add(question);
      }
    }
    return data;
  }
}

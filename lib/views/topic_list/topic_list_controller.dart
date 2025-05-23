import 'package:excel/excel.dart';
import 'package:flutter/services.dart';

class TopicListController {
  // get the data
  Future<List<List<String>>> getTopicData() async {
    // extract bits from asset
    ByteData bytes = await rootBundle.load('assets/topics.xlsx');
    List<int> bytList =
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
    var excel = Excel.decodeBytes(bytList);
    List<List<String>> data = [];
    // get titles and subtitles from 1 and 2 row
    for (var table in excel.tables.keys) {
      List<String> titles = excel.tables[table]!.rows[0]
          .where((cell) => cell != null)
          .map((cell) => cell!.value.toString())
          .toList();
      List<String> subtitles = excel.tables[table]!.rows[1]
          .where((cell) => cell != null)
          .map((cell) => cell!.value.toString())
          .toList();
      data = [titles, subtitles];
      break; //traverse only one sheet
    }
    return data;
  }
}

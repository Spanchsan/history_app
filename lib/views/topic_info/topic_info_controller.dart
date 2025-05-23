import 'package:excel/excel.dart';
import 'package:flutter/services.dart';

class TopicInfoController {
  Future<List<String>> fetchTopicInfoData(int? index) async {
    if (index == null) {
      return [];
    }
    ByteData bytes = await rootBundle.load('assets/topics.xlsx');
    List<int> bytList =
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
    var excel = Excel.decodeBytes(bytList);

    List<String> data = [];

    for (var table in excel.tables.keys) {
      int rI = 2;
      while (rI < 500) {
        String rData = excel.tables[table]!
            .cell(CellIndex.indexByColumnRow(columnIndex: index, rowIndex: rI))
            .value
            .toString();
        if (rData.isEmpty || rData == 'null') break;
        data.add(rData);
        rI++;
      }
      break;
    }
    return data;
  }
}

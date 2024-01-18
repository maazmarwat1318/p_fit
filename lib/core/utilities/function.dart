import 'package:flutter/services.dart';

class UtilFunction {
  static Future<String> readJsonFile(String name) async {
    final jsonData = await rootBundle.loadString('assets/json/$name');
    return jsonData;
  }

  static DateTime getDate() {
    final today = DateTime.now();
    final todayDate = DateTime(
      today.year,
      today.month,
      today.day,
    );
    return todayDate;
  }
}

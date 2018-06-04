import 'package:intl/intl.dart';

class Date {

  static String getDate(int offset, String type) {
    var mill =
        DateTime.now().millisecondsSinceEpoch - 24 * 3600 * 1000 * offset;
    return format(mill, type);
  }

  static String format(int millSecond, String type) {
    DateTime time = new DateTime.fromMillisecondsSinceEpoch(millSecond);
    var formatter = new DateFormat(type);
    var date = formatter.format(time);
    return date.toString();
  }
}

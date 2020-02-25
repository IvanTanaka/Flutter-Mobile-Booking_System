import 'package:intl/intl.dart';

class Helper{
  static String formatDate(DateTime dateTime, {String format="yyyy-MM-dd hh:mm:ss"}){
    return DateFormat(format).format(dateTime);
  }
}
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:intl/intl.dart';

class Helper{
  static String formatDate(DateTime dateTime, {String format="yyyy-MM-dd hh:mm:ss"}){
    return DateFormat(format).format(dateTime);
  }

  static String doubleToMoneyFormat(
      double amount, {
        String symbol,
        MoneyOutputAlligment symbolAlligment: MoneyOutputAlligment.LEFT,bool withSeparator = false
      }) {
    FlutterMoneyFormatter fmf = new FlutterMoneyFormatter(
      amount: amount,
      settings: MoneyFormatterSettings(
        symbol: symbol == null ? 'Rp ' : symbol,
        thousandSeparator: '.',
        decimalSeparator: '.',
        symbolAndNumberSeparator: withSeparator ? " ": "",
        fractionDigits: 0,
      ),
    );
    return symbolAlligment == MoneyOutputAlligment.LEFT
        ? fmf.output.symbolOnLeft
        : fmf.output.symbolOnRight;
  }
}


enum MoneyOutputAlligment { LEFT, RIGHT }
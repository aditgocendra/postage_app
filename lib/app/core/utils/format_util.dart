import 'package:intl/intl.dart';

class FormatUtility {
  static String currencyRupiah(int num) {
    return NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp. ',
      decimalDigits: 0,
    ).format(num);
  }
}

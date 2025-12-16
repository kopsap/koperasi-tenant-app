import 'package:intl/intl.dart';

part 'date.dart';

class Util {
  static final date = DateUtil();

  static String currency(double value) {
    bool belowZero = value < 0;

    return "${belowZero ? "-" : ""}Rp${NumberFormat('#,##0', 'id_ID').format(value.abs())}";
  }

  static double total(List data) {
    return data.fold(0, (total, row) => total + row);
  }

  static double avg(List data) {
    return total(data) / data.length;
  }

  static double max(List data) {
    return data.fold(0, (total, row) => row > total ? row : total);
  }

  static double min(List data, {bool excludeZero = true}) {
    return data.fold(0, (total, row) {
      if (excludeZero) {
        if (total == 0) {
          total = row;
        } else if (row == 0) {
          row = total;
        }
      }

      return row > total ? total : row;
    });
  }
}

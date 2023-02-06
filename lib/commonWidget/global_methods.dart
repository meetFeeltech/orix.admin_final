
import 'package:intl/intl.dart';

class GlobalMethods {


  static String convertToDMYFormat(String dateObj) {
    String dMyFormat = DateFormat("dd-MM-yyyy").format(DateTime.parse(dateObj));
    return dMyFormat;
  }

  static String convertToYMDFormat(String dateObj) {
    String yMdFormat = DateFormat("yyyy-MM-dd").format(DateTime.parse(dateObj));
    return yMdFormat;
  }

  static String convertToMMMFormat(String dateObj) {
    String MMMFormat = DateFormat("MMM").format(DateTime.parse(dateObj));
    return MMMFormat;
  }

  static String filterRangeFormat({DateTime? todayDate,DateTime? startDate, DateTime? endDate}) {
    String rangeFormat = 
      "${todayDate?.day != null ? '01' : startDate?.day} ${GlobalMethods.convertToMMMFormat((todayDate ?? startDate).toString())} ${(todayDate?.year ?? startDate?.year).toString().substring(2)}"
      " - "
      "${todayDate?.day ?? endDate?.day} ${GlobalMethods.convertToMMMFormat((todayDate ?? endDate).toString())} ${(todayDate?.year ?? endDate?.year).toString().substring(2)}";

    String rangeFormat2 =
        "${todayDate?.day != null ? '01' : startDate?.day} ${GlobalMethods.convertToMMMFormat((todayDate ?? startDate).toString())} ${(todayDate?.year ?? startDate?.year).toString().substring(2)}"
        " - "
        "${todayDate?.day ?? endDate?.day} ${GlobalMethods.convertToMMMFormat((todayDate ?? endDate).toString())} ${(todayDate?.year ?? endDate?.year).toString().substring(2)}";

    return rangeFormat;
  }



}
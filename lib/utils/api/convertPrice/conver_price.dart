import 'package:intl/intl.dart';

String formatPriceFromString(String priceString) {
  // Convert the string to a double
  double price = double.parse(priceString);

  // Create a NumberFormat instance for Vietnamese currency
  var formatter = NumberFormat.currency(locale: 'vi_VN', symbol: 'VNĐ');

  // Format the price and return the formatted string
  return formatter.format(price);
}

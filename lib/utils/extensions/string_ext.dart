import 'package:intl/intl.dart';


extension VietnameseTimeExtension on String {
  String convertToVietnameseTime() {
    try {
      // Parse the string into a DateTime object
      DateTime dateTime = DateTime.parse(this);

      // Extract components of the date
      String day = dateTime.day.toString().padLeft(2, '0');
      String month = dateTime.month.toString().padLeft(2, '0');
      String year = dateTime.year.toString();
      String hour = dateTime.hour.toString().padLeft(2, '0');
      String minute = dateTime.minute.toString().padLeft(2, '0');

      // Construct the formatted date string in Vietnamese format
      String formattedDate = 'Ngày $day/$month/$year Giờ: $hour:$minute';

      return formattedDate;
    } catch (e) {
      // Handle any parsing errors
      return 'Invalid date';
    }
  }
}


extension DistanceConversionExtension on String {
  String convertToKilometers() {
    try {
      // Extract the numeric part from the string (ignoring the " meters" part)
      double meters = double.parse(replaceAll(RegExp(r'[^0-9.]'), ''));

      // Convert meters to kilometers
      double kilometers = meters / 1000;

      // Return the result as a string with " km" appended
      return '${kilometers.toStringAsFixed(2)} km';
    } catch (e) {
      // Handle any parsing errors
      return 'Invalid distance';
    }
  }
}



extension PriceFormattingExtension on String {
  String formatPriceFromString() {
    try {
      // Convert the string to a double
      double price = double.parse(this);

      // Create a NumberFormat instance for Vietnamese currency
      var formatter = NumberFormat.currency(locale: 'vi_VN', symbol: 'điểm');

      // Format the price and return the formatted string
      return formatter.format(price);
    } catch (e) {
      // Handle any parsing errors
      return 'Invalid price';
    }
  }
}

extension TruncateWithWordsExtension on String {
  String truncateWithWords(int maxWords) {
    final words = split(' ');
    if (words.length <= maxWords) return this;
    return '${words.sublist(0, maxWords).join(' ')}...';
  }
}

String convertToVietnameseTime(String dateString) {
  try {
    // Parse the string into a DateTime object
    DateTime dateTime = DateTime.parse(dateString);

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

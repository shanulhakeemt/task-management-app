import 'package:intl/intl.dart';

DateTime monthToDateTime(String dateString) {
  // Define the month mapping
  const months = {
    'Jan': 1,
    'Feb': 2,
    'Mar': 3,
    'Apr': 4,
    'May': 5,
    'Jun': 6,
    'Jul': 7,
    'Aug': 8,
    'Sep': 9,
    'Oct': 10,
    'Nov': 11,
    'Dec': 12
  };

  // Split the input string (e.g., 'Dec 16 2030')
  var parts = dateString.split(' ');
  int month = months[parts[0]]!;
  int day = int.parse(parts[1]);
  int year = int.parse(parts[2]);

  // Return a DateTime object
  return DateTime(year, month, day);
}

String getRelativeDay(String dateString) {
  // Parse the date string to DateTime
  DateTime inputDate = DateFormat('MMM dd yyyy').parse(dateString);
  DateTime now = DateTime.now();

  // Get today's date, yesterday, and tomorrow for comparison
  DateTime today = DateTime(now.year, now.month, now.day);
  DateTime yesterday = today.subtract(const Duration(days: 1));
  DateTime tomorrow = today.add(const Duration(days: 1));

  // Compare the input date with today, yesterday, and tomorrow
  if (inputDate == today) {
    return "Today";
  } else if (inputDate == yesterday) {
    return "Yesterday";
  } else if (inputDate == tomorrow) {
    return "Tomorrow";
  } else {
    // Format the date for other days
    return DateFormat('MMM dd yyyy').format(inputDate);
  }
}

bool checkTheDayIsBeforeToday(String dateString) {
  DateTime today = DateTime.now();
  DateTime currentDay = DateTime(today.year, today.month, today.day);

  DateTime parsedDate = DateFormat('MMM dd yyyy').parse(dateString);

  return parsedDate.isBefore(currentDay);
}

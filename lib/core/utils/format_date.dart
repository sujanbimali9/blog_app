import 'package:intl/intl.dart';

String formatDatedMMYYYY(DateTime date) {
  return DateFormat('d MMM, yyyy').format(date);
}

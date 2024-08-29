import 'package:intl/intl.dart';

class AppFormatters {
  static final dateHM = DateFormat('EEE, MMM d, yyyy - HH:mm aaa');

  static final full = DateFormat.yMEd().add_jms();
}

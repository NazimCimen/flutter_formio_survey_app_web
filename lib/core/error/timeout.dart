import 'package:flutter_survey_app_web/core/error/exception.dart';

class TimeoutHandler {
  static const Duration timeoutDuration = Duration(seconds: 15);

  static Exception timeoutException =
      TimeoutException('Image upload timed out');
}

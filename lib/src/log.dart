import 'package:flutter/foundation.dart';

// bool isPrintLog = false;

void log(data) {
  if (kDebugMode) {
    print(data);
  }
}

import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

class Environment {
  static String apiUrl = kIsWeb
      ? 'http://azure01hn.eastus2.cloudapp.azure.com:8070/api'
      : Platform.isAndroid
          ? 'http://azure01hn.eastus2.cloudapp.azure.com:8070/api'
          : 'http://localhost:7161';
  static String socketUrl = kIsWeb
      ? 'http://158.69.125.70:8080'
      : Platform.isAndroid
          ? 'http://158.69.125.70:8080'
          : 'http://localhost:7161';
}

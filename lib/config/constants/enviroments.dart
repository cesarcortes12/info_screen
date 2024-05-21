import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

class Environment {
  static String apiUrl = kIsWeb
      ? 'http://192.168.6.66:8081/api' // URL para producción o desarrollo web
      : Platform.isAndroid
          ? 'http://192.168.6.66:8081/api'
          : 'http://localhost:7161';
  static String socketUrl = kIsWeb
      ? 'http://158.69.125.70:8080' // URL para producción o desarrollo web
      : Platform.isAndroid
          ? 'http://158.69.125.70:8080'
          : 'http://localhost:7161';
}
/*class Environment {
  static String apiUrl = Platform.isAndroid
      ? 'http://dmspruebas01.eastus2.cloudapp.azure.com:8084/api'
      : 'http://localhost:7161';
  static String socketUrl = Platform.isAndroid
      ? 'http://192.168.6.118:8081'
      : 'http://localhost:7161';
}*/

import 'dart:io';

class Environment {
  static String apiUrl = Platform.isAndroid
      ? 'http://dmspruebas01.eastus2.cloudapp.azure.com:8084/api'
      : 'http://localhost:7161';
  static String socketUrl = Platform.isAndroid
      ? 'http://192.168.6.118:8081'
      : 'http://localhost:7161';
}

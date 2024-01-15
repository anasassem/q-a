import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:device_info_plus/device_info_plus.dart';

@injectable
class GetDeviceId {
  Future<String?> get deviceId async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        print("##########${androidInfo.id}");
        return androidInfo.id; // Android ID
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        return iosInfo.identifierForVendor; // iOS identifierForVendor
      }
    } catch (e) {
      print("Error getting device ID: $e");
      return null;
    }
  }
}

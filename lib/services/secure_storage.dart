import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class SecureStorage{
  static IOSOptions iosOptions = const IOSOptions(accessibility: KeychainAccessibility.first_unlock);
  static AndroidOptions androidOptions = const AndroidOptions();

  static FlutterSecureStorage storage = FlutterSecureStorage(
    iOptions: iosOptions,
    aOptions: androidOptions
  );

  static Future<void> storeOneValue({required String key, required String value}) async {
    await storage.write(key: key, value: value);
  }

  static Future<void> storeMap({required String key, required Map map}) async {
    await storage.write(key: key, value: jsonEncode(map));
  }

  static Future<void> storeMultipleValues({required Map<String, dynamic> map}) async {
    map.forEach((key, value) async {
      await storage.write(key: key, value: value.toString());
    });
  }

  static Future<String?> readOneValue({required String key}) async {
    return await storage.read(key: key);
  }

  static Future<Map> readAll() async {
    return await storage.readAll();
  }

  static Future<void> deleteOneValue({required String key}) async {
    await storage.delete(key: key);
  }

  static Future<void> deleteAll() async {
    await storage.deleteAll();
  }

}

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

Future getStorageByKey (String key) async {
  return await storage.read(key: key);
}

setStorage ({String key, String value}) async {
  await storage.write(key: key, value: value);
}

deleteStorage ({String key}) async {
  await storage.delete(key: key);
}


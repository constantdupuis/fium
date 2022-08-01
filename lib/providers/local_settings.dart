import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/api_serveur.dart';

class LocalSettings extends ChangeNotifier {
  static const String apiServeursBox = "ApiServeurs";
  static const String appSettingsBox = "AppSettings";

  static void init() async {
    await Hive.initFlutter();
    await Hive.openBox(apiServeursBox);
    Hive.registerAdapter(ApiServeurAdapter());
  }
}

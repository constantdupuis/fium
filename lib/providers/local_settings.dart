import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/api_server.dart';

final localSettingsProvider =
    ChangeNotifierProvider<LocalSettings>((ref) => LocalSettings());

class LocalSettings extends ChangeNotifier {
  static const String apiServeursBox = "ApiServeurs";
  static const String appSettingsBox = "AppSettings";
  late Box<ApiServer> apiServers;
  bool isLoaded = false;

  static void init() async {
    await Hive.initFlutter();
  }

  Future<void> load() async {
    if (isLoaded) return;

    Hive.registerAdapter(ApiServerAdapter());
    apiServers = await Hive.openBox<ApiServer>(apiServeursBox);
    isLoaded = true;
  }

  Future<List<ApiServer>> getApiServerList() async {
    await load();
    return apiServers.values.toList();
  }

  Future<int> addApiServer(ApiServer apiServer) async {
    final ret = await apiServers.add(apiServer);
    notifyListeners();
    return ret;
  }

  Future<void> saveApiServer(ApiServer apiServer) async {
    final ret = await apiServer.save();
    notifyListeners();
    return ret;
  }

  Future<void> removeApiServer(ApiServer apiServer) async {
    final ret = apiServer.delete();
    notifyListeners();
    return ret;
  }

  ApiServer? getApiServer(dynamic key) {
    return apiServers.get(key);
  }
}

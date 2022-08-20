import 'package:hive/hive.dart';

part 'api_server.g.dart';

@HiveType(typeId: 1)
class ApiServer extends HiveObject {
  @HiveField(0)
  String name = '';
  @HiveField(1)
  String url = '';
  @HiveField(2)
  String username = '';
  @HiveField(3)
  String password = '';
}

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

  @override
  bool operator ==(Object other) =>
      other is ApiServer &&
      other.name == name &&
      other.url == url &&
      other.username == username &&
      other.password == password;

  @override
  int get hashCode {
    return '$name$url$username$password'.hashCode;
  }
}

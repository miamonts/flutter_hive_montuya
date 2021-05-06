import 'package:hive/hive.dart';

part 'users2.dart';

@HiveType(typeId: 1)
class Uscores {
  @HiveField(0)
  String username;

  @HiveField(1)
  int score;

  @HiveField(2)
  String password;

  Uscores(this.username, this.score, this.password);
}

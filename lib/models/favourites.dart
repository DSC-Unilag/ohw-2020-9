import 'package:hive/hive.dart';
part 'favourites.g.dart';

@HiveType()
class Favourites {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String url;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final int boxCount;

  Favourites({this.id, this.url, this.name, this.boxCount});
}

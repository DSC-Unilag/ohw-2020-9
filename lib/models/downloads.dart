import 'package:hive/hive.dart';
part 'downloads.g.dart';

@HiveType()
class Downloads {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int size;

  @HiveField(3)
  final String path;

  Downloads({this.id, this.name, this.size, this.path});
}

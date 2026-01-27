import 'package:isar/isar.dart';
part 'category.g.dart';


@collection
class Category {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  final String name;

  Category({this.id = Isar.autoIncrement, required this.name});
}

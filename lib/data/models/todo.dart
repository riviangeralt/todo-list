import 'package:isar/isar.dart';
part "todo.g.dart";

@Collection()
class TodoModel {
  Id id = Isar.autoIncrement;
  late String title;
  late String? description;
  late String type;
}

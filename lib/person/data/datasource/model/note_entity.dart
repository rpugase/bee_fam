import 'package:hive/hive.dart';

part 'note_entity.g.dart';

@HiveType(typeId: 2)
class NoteEntity extends HiveObject {

  static const String TABLE_NAME = "Note";

  @HiveField(0)
  final String text;

  NoteEntity(this.text);

  @override
  String toString() {
    return "NoteEntity(text=$text)";
  }
}

import 'package:hive/hive.dart';

import '../hive_constants.dart';

part 'note_entity.g.dart';

@HiveType(typeId: HiveConst.noteTypeId)
class NoteEntity extends HiveObject {

  static Future<Box<NoteEntity>> createBox() async {
    return Hive.openBox<NoteEntity>(HiveConst.noteTableName);
  }

  @HiveField(0)
  final String text;

  NoteEntity(this.text);

  @override
  String toString() {
    return "NoteEntity(text=$text)";
  }
}

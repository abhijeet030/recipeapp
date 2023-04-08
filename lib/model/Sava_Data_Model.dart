import 'package:hive/hive.dart';
part 'Sava_Data_Model.g.dart';

@HiveType(typeId: 0)
class SaveDataModel extends HiveObject {
  @HiveField(0)
  String image;

  @HiveField(1)
  String url;

  @HiveField(2)
  String source;

  @HiveField(3)
  String label;

  @HiveField(4)
  List<String> ingredientLines;

  SaveDataModel({
    required this.image,
    required this.url,
    required this.source,
    required this.label,
    required this.ingredientLines,
  });
}

import 'package:recipe/model/Sava_Data_Model.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<SaveDataModel> getData() => Hive.box<SaveDataModel>('SaveData');
}

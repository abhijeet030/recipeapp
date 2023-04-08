// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Sava_Data_Model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SaveDataModelAdapter extends TypeAdapter<SaveDataModel> {
  @override
  final int typeId = 0;

  @override
  SaveDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SaveDataModel(
      image: fields[0] as String,
      url: fields[1] as String,
      source: fields[2] as String,
      label: fields[3] as String,
      ingredientLines: (fields[4] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, SaveDataModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.image)
      ..writeByte(1)
      ..write(obj.url)
      ..writeByte(2)
      ..write(obj.source)
      ..writeByte(3)
      ..write(obj.label)
      ..writeByte(4)
      ..write(obj.ingredientLines);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SaveDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

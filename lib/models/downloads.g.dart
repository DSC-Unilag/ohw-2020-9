// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'downloads.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DownloadsAdapter extends TypeAdapter<Downloads> {
  @override
  Downloads read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Downloads(
      id: fields[0] as String,
      name: fields[1] as String,
      size: fields[2] as int,
      path: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Downloads obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.size)
      ..writeByte(3)
      ..write(obj.path);
  }

  @override
  int get typeId => 1;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourites.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavouritesAdapter extends TypeAdapter<Favourites> {
  @override
  Favourites read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Favourites(
      id: fields[0] as String,
      url: fields[1] as String,
      name: fields[2] as String,
      boxCount: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Favourites obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.url)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.boxCount);
  }

  @override
  int get typeId => 0;
}

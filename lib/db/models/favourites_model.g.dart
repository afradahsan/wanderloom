// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourites_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavouritesModelAdapter extends TypeAdapter<FavouritesModel> {
  @override
  final int typeId = 1;

  @override
  FavouritesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavouritesModel(
      id: fields[0] as String?,
      placeName: fields[1] as String?,
      location: fields[2] as String?,
      image: fields[3] as String?,
      doc: fields[4] as QueryDocumentSnapshot<Object>?,
    );
  }

  @override
  void write(BinaryWriter writer, FavouritesModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.placeName)
      ..writeByte(2)
      ..write(obj.location)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.doc);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavouritesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

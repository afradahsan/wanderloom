// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'placemodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlaceModelAdapter extends TypeAdapter<PlaceModel> {
  @override
  final int typeId = 0;

  @override
  PlaceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlaceModel(
      placeID: fields[0] as String,
      placeName: fields[1] as String,
      location: fields[2] as String,
      image: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PlaceModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.placeID)
      ..writeByte(1)
      ..write(obj.placeName)
      ..writeByte(2)
      ..write(obj.location)
      ..writeByte(3)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

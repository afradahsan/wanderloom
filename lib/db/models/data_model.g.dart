// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TripDetailsModelAdapter extends TypeAdapter<TripDetailsModel> {
  @override
  final int typeId = 1;

  @override
  TripDetailsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TripDetailsModel(
      id: fields[0] as int?,
      tripptitle: fields[1] as String?,
      trippbudget: fields[2] as String?,
      trippdate: fields[3] as String?,
      trippcategorytitle: fields[4] as String?,
      trippcategoryiconpath: fields[5] as String?,
      participants: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TripDetailsModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.tripptitle)
      ..writeByte(2)
      ..write(obj.trippbudget)
      ..writeByte(3)
      ..write(obj.trippdate)
      ..writeByte(4)
      ..write(obj.trippcategorytitle)
      ..writeByte(5)
      ..write(obj.trippcategoryiconpath)
      ..writeByte(6)
      ..write(obj.participants);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TripDetailsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

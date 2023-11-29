import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class QueryDocumentSnapshotAdapter extends TypeAdapter<QueryDocumentSnapshot> {
  @override
  final int typeId = 0; // Unique adapter ID

  @override
  QueryDocumentSnapshot read(BinaryReader reader) {
    var dataLength = reader.readUint32();
    var data = reader.readList(dataLength);
    return data.isNotEmpty ? data[0] as QueryDocumentSnapshot : '' as QueryDocumentSnapshot;
  }

  @override
  void write(BinaryWriter writer, QueryDocumentSnapshot obj) {
    writer.writeList([obj]);
  }
}

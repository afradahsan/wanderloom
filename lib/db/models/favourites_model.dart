import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

part 'favourites_model.g.dart';  

@HiveType(typeId: 1)
class FavouritesModel {
  @HiveField(0)
  String? id;

  @HiveField(1)
  final String? placeName;

  @HiveField(2)
  final String? location;

  @HiveField(3)
  final String? image;

  @HiveField(4)
  final QueryDocumentSnapshot? doc; 

  FavouritesModel({
    required this.id,
    required this.placeName,
    required this.location,
    required this.image,
    required this.doc,
  });
}

import 'package:hive/hive.dart';

part 'placemodel.g.dart';

@HiveType(typeId: 0)
class PlaceModel extends HiveObject {
  @HiveField(0)
  late String placeID;

  @HiveField(1)
  late String placeName;

  @HiveField(2)
  late String location;

  @HiveField(3)
  late String image;

  PlaceModel({required this.placeID, required this.placeName,required this.location, required this.image});
}

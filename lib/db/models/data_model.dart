import 'package:hive/hive.dart';
part 'data_model.g.dart';

@HiveType(typeId: 1)
class TripDetailsModel{

  @HiveField(0)
  int? id;

  @HiveField(1)
  final String? tripptitle;

  @HiveField(2)
  final String? trippbudget;

  @HiveField(3)
  final String? trippdate;

  @HiveField(4)
  final String? trippcategorytitle;

  @HiveField(5)
  final String? trippcategoryiconpath;

  @HiveField(6)
  final String? participants;
  
  TripDetailsModel({
    this.id,
    required this.tripptitle,
    required this.trippbudget,
    required this.trippdate,
    required this.trippcategorytitle,
    required this.trippcategoryiconpath,
    required this.participants,
  });
}


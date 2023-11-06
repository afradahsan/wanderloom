import 'package:hive_flutter/hive_flutter.dart';
import 'package:wanderloom/db/models/data_model.dart';
part 'signup_model.g.dart';


@HiveType(typeId: 2)
class UserModel{

  @HiveField(0)
  int? id;

  @HiveField(1)
  final String? email;

  @HiveField(2)
  final String? username;

  @HiveField(3)
  final String? password;

  @HiveField(4)
  List<TripDetailsModel> tripdetailslist;

  UserModel({
    this.id,
    required this.username,
    required this.email,
    required this.password,
    this.tripdetailslist = const []
  });
}
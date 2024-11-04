import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

// @freezed
// @HiveType(typeId: 0, adapterName: 'UserModelAdapter')
// class UserModel extends HiveObject with _$UserModel {
//   const factory UserModel({
//     @HiveField(0) required int userId,
//     @HiveField(1) required String username,
//     @HiveField(2) required String phone,
//     @HiveField(3) required String email,
//     @HiveField(4) required String role,
//     @HiveField(5) required bool status,
//   }) = _UserModel;

// }

@freezed
@HiveType(typeId: 0, adapterName: 'UserModelAdapter')

abstract class UserModel extends HiveObject with _$UserModel {
  UserModel._();

  @HiveType(typeId: 5)
  factory UserModel({
    @HiveField(0) required int userId,
    @HiveField(1) required String username,
    @HiveField(2) required String phone,
    @HiveField(3) required String email,
    @HiveField(4) required String role,
    @HiveField(5) required bool status,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

}
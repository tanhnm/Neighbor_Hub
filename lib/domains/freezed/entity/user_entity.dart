// To parse this JSON data, do
//
//     final UserEntity = UserEntityFromMap(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'user_entity.freezed.dart';
part 'user_entity.g.dart';

UserEntity UserEntityFromMap(String str) =>
    UserEntity.fromMap(json.decode(str));

String UserEntityToMap(UserEntity data) => json.encode(data.toMap());

@freezed
class UserEntity with _$UserEntity {
  const factory UserEntity({
    int userId,
    String username,
    String phone,
    String email,
    String password,
    String role,
    bool status,
  }) = _UserEntity;

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);
}

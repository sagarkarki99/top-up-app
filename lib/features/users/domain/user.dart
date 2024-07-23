import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  factory User({
    required String id,
    @Default(0) double balance,
    @Default(false) bool isVerified,
  }) = _User;
}

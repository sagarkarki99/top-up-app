import 'package:freezed_annotation/freezed_annotation.dart';

part 'beneficiary.freezed.dart';

@freezed
class Beneficiary with _$Beneficiary {
  factory Beneficiary({
    required String id,
    required String name,
    required String phoneNumber,
  }) = _Beneficiary;
}

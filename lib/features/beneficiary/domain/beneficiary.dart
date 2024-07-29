import 'package:freezed_annotation/freezed_annotation.dart';

part 'beneficiary.freezed.dart';

@freezed
class Beneficiary with _$Beneficiary {
  /// Beneficiary information
  factory Beneficiary({
    required String id,
    required String name,
    required String phoneNumber,
  }) = _Beneficiary;

  @override
  bool operator ==(Object other) {
    return other is Beneficiary && other.phoneNumber == phoneNumber;
  }
}

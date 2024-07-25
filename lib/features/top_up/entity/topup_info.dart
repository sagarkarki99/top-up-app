import 'package:freezed_annotation/freezed_annotation.dart';

part 'topup_info.freezed.dart';

@freezed
class TopupInfo with _$TopupInfo {
  factory TopupInfo({
    required String id,
    required String beneficiaryName,
    required String beneficiaryPhoneNumber,
    required double fee,
    required BalanceInfo totalToppedupAmount,
    required BalanceInfo beneficiaryToppedupAmount,
  }) = _TopupInfo;
}

@freezed
class BalanceInfo with _$BalanceInfo {
  factory BalanceInfo({
    required double allowed,
    required double available,
  }) = _BalanceInfo;
}

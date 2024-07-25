part of 'topup_cubit.dart';

@freezed
class TopupState with _$TopupState {
  const factory TopupState({
    required TextEditingController amountController,
    TopupInfo? beneficiaryTopupInfo,
    @Default(TopupInfoStatus.settingUp()) TopupInfoStatus topupInfoStatus,
    @Default(TopupStatus.idle()) TopupStatus topupStatus,
  }) = _TopupState;
}

@freezed
class TopupInfoStatus with _$TopupInfoStatus {
  const factory TopupInfoStatus.settingUp() = SettingUp;
  const factory TopupInfoStatus.loaded() = Loaded;
  const factory TopupInfoStatus.setupFailed(String errorMessage) = SetupFailed;
}

@freezed
class TopupStatus with _$TopupStatus {
  const factory TopupStatus.idle() = _Idle;
  const factory TopupStatus.toppingUp() = _ToppingUp;
  const factory TopupStatus.topupFailed(String errorMessage) = _TopupFailed;
  const factory TopupStatus.topupSuccess(String errorMessage) = _TopupSuccess;
}

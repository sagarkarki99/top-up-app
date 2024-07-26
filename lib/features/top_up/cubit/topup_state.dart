part of 'topup_cubit.dart';

@freezed
class TopupState with _$TopupState {
  const factory TopupState({
    @Default('') String validationMessage,
    @Default([]) List<double> topupOptions,
    double? selected,
    double? finalSendingAmount,
    TopupInfo? beneficiaryTopupInfo,
    @Default(TopupInfoStatus.settingUp()) TopupInfoStatus topupInfoStatus,
    @Default(TopupStatus.idle()) TopupStatus topupStatus,
  }) = _TopupState;

  const TopupState._();
}

@freezed
class TopupInfoStatus with _$TopupInfoStatus {
  const factory TopupInfoStatus.settingUp() = SettingUp;
  const factory TopupInfoStatus.loaded() = Loaded;
  const factory TopupInfoStatus.setupFailed(String errorMessage) = SetupFailed;
}

@freezed
class TopupStatus with _$TopupStatus {
  const factory TopupStatus.idle() = Idle;
  const factory TopupStatus.readyToTopup() = ReadyToTopup;
  const factory TopupStatus.toppingUp() = ToppingUp;
  const factory TopupStatus.topupFailed(String errorMessage) = TopupFailed;
  const factory TopupStatus.topupSuccess(TopupSuccessEntity entity) =
      TopupSuccess;
}

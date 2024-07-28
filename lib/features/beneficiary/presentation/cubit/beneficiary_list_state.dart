part of 'beneficiary_list_cubit.dart';

@freezed
class BeneficiaryListState with _$BeneficiaryListState {
  const factory BeneficiaryListState({
    @Default([]) List<Beneficiary> beneficiaries,
    @Default(BeneficiaryListStatus.fetching()) BeneficiaryListStatus status,
  }) = _BeneficiaryListState;
}

@freezed
class BeneficiaryListStatus with _$BeneficiaryListStatus {
  const factory BeneficiaryListStatus.fetching() = Fetching;
  const factory BeneficiaryListStatus.loaded() = BeneficiariesLoaded;
  const factory BeneficiaryListStatus.error(String errorMessage) = Error;
  const factory BeneficiaryListStatus.empty(String message) = Empty;
}

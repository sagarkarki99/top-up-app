part of 'beneficiary_list_cubit.dart';

@freezed
class BeneficiaryListState with _$BeneficiaryListState {
  const factory BeneficiaryListState.fetching() = _Fetching;
  const factory BeneficiaryListState.loaded(List<Beneficiary> list) = _Loaded;
  const factory BeneficiaryListState.error(String errorMessage) = _Error;
  const factory BeneficiaryListState.empty(String message) = _Empty;
}

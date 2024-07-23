part of 'beneficiary_list_cubit.dart';

@freezed
class BeneficiaryListState with _$BeneficiaryListState {
  const factory BeneficiaryListState.initial() = _Initial;
  const factory BeneficiaryListState.fetching() = _Fetching;
  const factory BeneficiaryListState.loaded(List<Beneficiary> list) = _Loaded;
}

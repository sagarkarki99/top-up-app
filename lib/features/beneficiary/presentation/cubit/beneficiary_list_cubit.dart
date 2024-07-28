import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:top_up_app/features/beneficiary/domain/beneficiary.dart';
import 'package:top_up_app/features/beneficiary/service/beneficiary_service.dart';
import 'package:top_up_app/features/users/domain/user.dart';

part 'beneficiary_list_state.dart';
part 'beneficiary_list_cubit.freezed.dart';

class BeneficiaryListCubit extends Cubit<BeneficiaryListState> {
  BeneficiaryListCubit({
    required this.beneficiaryService,
    required this.user,
  }) : super(const BeneficiaryListState(
          maxAllowedBeneficiaries: _maxNumberOfBeneficiaries,
        ));

  final BeneficiaryService beneficiaryService;
  final User user;
  static const _maxNumberOfBeneficiaries = 5;

  void fetchBeneficiaries() async {
    emit(state.copyWith(status: const BeneficiaryListStatus.fetching()));
    final beneficiaries = await beneficiaryService.fetchBeneficiaries(user.id);
    if (beneficiaries.isEmpty) {
      emit(
        state.copyWith(
            status: const BeneficiaryListStatus.empty(
          'Beneficiaries list is empty.',
        )),
      );
    } else {
      emit(state.copyWith(
          beneficiaries: beneficiaries,
          status: const BeneficiaryListStatus.loaded()));
    }
  }

  void addBeneficiary(Beneficiary beneficiary) async {
    if (state.beneficiaries.contains(beneficiary)) {
      return emit(
        state.copyWith(
          status:
              const BeneficiaryListStatus.error('Beneficiary already exists.'),
        ),
      );
    }
    final updatedBeneficiary = await beneficiaryService.addNewBeneficiary(
      user.id,
      beneficiary,
    );
    emit(state.copyWith(
      beneficiaries: List.of(state.beneficiaries)
        ..insert(0, updatedBeneficiary),
      status: const BeneficiaryListStatus.loaded(),
    ));
  }
}

import 'package:flutter/rendering.dart';
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
  }) : super(const BeneficiaryListState());

  final BeneficiaryService beneficiaryService;
  final User user;

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
    final updatedBeneficiary =
        await beneficiaryService.addNewBeneficiary(user.id, beneficiary);
  }
}

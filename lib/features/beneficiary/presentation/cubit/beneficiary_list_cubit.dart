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
  }) : super(const BeneficiaryListState.fetching());

  final BeneficiaryService beneficiaryService;
  final User user;

  void fetchBeneficiaries() async {
    emit(const BeneficiaryListState.fetching());
    final beneficiaries = await beneficiaryService.fetchBeneficiaries(user.id);
    emit(BeneficiaryListState.loaded(beneficiaries));
  }
}

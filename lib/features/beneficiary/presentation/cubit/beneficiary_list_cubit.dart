import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'beneficiary_list_state.dart';
part 'beneficiary_list_cubit.freezed.dart';

class BeneficiaryListCubit extends Cubit<BeneficiaryListState> {
  BeneficiaryListCubit() : super(BeneficiaryListState.initial());
}

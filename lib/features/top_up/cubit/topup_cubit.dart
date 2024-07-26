import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:top_up_app/features/top_up/entity/topup_info.dart';
import 'package:top_up_app/features/top_up/entity/topup_success_entity.dart';
import 'package:top_up_app/features/top_up/service/topup_service.dart';
import 'package:top_up_app/features/users/domain/user.dart';

part 'topup_state.dart';
part 'topup_cubit.freezed.dart';

class TopupCubit extends Cubit<TopupState> {
  TopupCubit({
    required this.user,
    required this.topupService,
    required this.beneficiaryId,
  }) : super(const TopupState());

  final User user;
  final TopupService topupService;
  final String beneficiaryId;

  Future<void> setupTopupEnvironment() async {
    try {
      emit(state.copyWith(topupInfoStatus: const TopupInfoStatus.settingUp()));
      final info = await topupService.fetchTopupInfo(user.id, beneficiaryId);
      emit(state.copyWith(
        beneficiaryTopupInfo: info,
        topupOptions: [5.0, 10.0, 20.0, 30, 50, 75, 100],
        topupInfoStatus: const TopupInfoStatus.loaded(),
      ));
    } on Exception {
      emit(
        state.copyWith(
          topupInfoStatus:
              const TopupInfoStatus.setupFailed('Failed to fetch information'),
        ),
      );
    }
  }

  void updateSelection(double amount) {
    // logic for balance checking (along with fee)
    if (user.balance < amount + state.beneficiaryTopupInfo!.fee) {
      emit(
        state.copyWith(
          selected: amount,
          topupStatus: const TopupStatus.idle(),
          validationMessage: 'You do not have enough balance to top up.',
        ),
      );
    } else if (state.beneficiaryTopupInfo!.totalToppedupAmount.available == 0) {
      emit(
        state.copyWith(
          selected: amount,
          topupStatus: const TopupStatus.idle(),
          validationMessage:
              'You have reached maximum amount of ${state.beneficiaryTopupInfo!.totalToppedupAmount.allowed} for this month.',
        ),
      );
    } else {
      emit(
        state.copyWith(
          selected: amount,
          topupStatus: const TopupStatus.readyToTopup(),
          validationMessage: '',
        ),
      );
    }
  }

  Future<void> confirmTopup() async {
    if (state.selected == null) {
      return;
    }

    emit(state.copyWith(
      topupStatus: const TopupStatus.toppingUp(),
      finalSendingAmount: state.selected! + state.beneficiaryTopupInfo!.fee,
    ));
    final response = await topupService.topup(
      user.id,
      beneficiaryId,
      state.selected!,
    );
    emit(state.copyWith(topupStatus: TopupStatus.topupSuccess(response)));
  }
}
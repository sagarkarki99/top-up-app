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
    required User user,
    required TopupService topupService,
    required String beneficiaryId,
  })  : _topupService = topupService,
        _beneficiaryId = beneficiaryId,
        _user = user,
        super(const TopupState());

  final User _user;
  final TopupService _topupService;
  final String _beneficiaryId;
  static const List<double> _topupOptions = [5, 10, 20, 30, 50, 75, 100];

  Future<void> setupTopupEnvironment() async {
    try {
      emit(state.copyWith(topupInfoStatus: const TopupInfoStatus.settingUp()));
      final info = await _topupService.fetchTopupInfo(_user.id, _beneficiaryId);
      emit(state.copyWith(
        topupOptions: _topupOptions,
        beneficiaryTopupInfo: info,
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
    if (_isBalanceAvailable(amount)) {
      _emitValidationState(amount, 'You do not have enough balance to top up.');
    } else if (_isBeneficiaryLimitReached()) {
      _emitValidationState(
        amount,
        _user.isVerified
            ? 'Your limit to top up ${state.beneficiaryTopupInfo!.beneficiaryName} has been reached.'
            : 'Your limit to top up ${state.beneficiaryTopupInfo!.beneficiaryName} has been reached. Please verify you account to extend your limit.',
      );
    } else if (_isBeneficiaryLimitCrossed(amount)) {
      _emitValidationState(
        amount,
        _user.isVerified
            ? 'Your limit to top up ${state.beneficiaryTopupInfo!.beneficiaryName} has been reached.'
            : 'Your limit to top up ${state.beneficiaryTopupInfo!.beneficiaryName} has been reached. Please verify you account to extend your limit.',
      );
    } else if (_isTotalLimitReached()) {
      _emitValidationState(
        amount,
        'You have reached maximum amount of ${state.beneficiaryTopupInfo!.totalToppedupAmount.allowed} for this month.',
      );
    } else if (_isTotalLimitCrossed(amount)) {
      _emitValidationState(
        amount,
        'Your available balance to top up for this month is AED ${state.beneficiaryTopupInfo!.totalToppedupAmount.available}.',
      );
    } else {
      emit(
        state.copyWith(
          selected: amount,
          topupStatus: const TopupStatus.readyToTopup(),
          validationMessage: '',
          finalSendingAmount: amount + state.beneficiaryTopupInfo!.fee,
        ),
      );
    }
  }

  bool _isTotalLimitCrossed(double amount) {
    return state.beneficiaryTopupInfo!.totalToppedupAmount.available < amount;
  }

  bool _isTotalLimitReached() =>
      state.beneficiaryTopupInfo!.totalToppedupAmount.available == 0;

  bool _isBeneficiaryLimitReached() {
    return state.beneficiaryTopupInfo!.beneficiaryToppedupAmount.available == 0;
  }

  bool _isBeneficiaryLimitCrossed(double amount) {
    return state.beneficiaryTopupInfo!.beneficiaryToppedupAmount.available <
        amount;
  }

  bool _isBalanceAvailable(double amount) =>
      _user.balance < amount + state.beneficiaryTopupInfo!.fee;

  void _emitValidationState(double amount, String validationMmessage) {
    return emit(
      state.copyWith(
        selected: amount,
        topupStatus: const TopupStatus.idle(),
        finalSendingAmount: amount + state.beneficiaryTopupInfo!.fee,
        validationMessage: validationMmessage,
      ),
    );
  }

  Future<void> confirmTopup() async {
    if (state.selected == null) {
      return;
    }

    emit(state.copyWith(
      topupStatus: const TopupStatus.toppingUp(),
      finalSendingAmount: state.selected! + state.beneficiaryTopupInfo!.fee,
    ));
    final response = await _topupService.topup(
      _user.id,
      _beneficiaryId,
      state.selected ?? 0,
    );
    emit(state.copyWith(topupStatus: TopupStatus.topupSuccess(response)));
  }
}

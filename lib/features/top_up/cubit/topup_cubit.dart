import 'package:flutter/material.dart';
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
  }) : super(TopupState(amountController: TextEditingController()));

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

  updateSelection(double amount) {
    emit(state.copyWith(selected: amount));
  }

  Future<void> confirmTopup() async {
    emit(state.copyWith(topupStatus: const TopupStatus.toppingUp()));
    final response = await topupService.topup(
      user.id,
      beneficiaryId,
      double.parse(state.amountController.text),
    );
    emit(
      state.copyWith(
        topupStatus: TopupStatus.topupSuccess(response),
      ),
    );
  }
}

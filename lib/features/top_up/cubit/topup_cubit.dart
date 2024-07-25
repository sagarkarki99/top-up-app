import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:top_up_app/features/top_up/entity/topup_info.dart';
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
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:top_up_app/features/top_up/service/topup_service.dart';
import 'package:top_up_app/features/users/domain/user.dart';

part 'topup_state.dart';
part 'topup_cubit.freezed.dart';

class TopupCubit extends Cubit<TopupState> {
  TopupCubit({
    required this.user,
    required this.topupService,
    required beneficiaryId,
  }) : super(const TopupState.initial());

  final User user;
  final TopupService topupService;
}

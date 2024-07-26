import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:top_up_app/features/users/domain/user.dart';

part 'user_state.dart';
part 'user_cubit.freezed.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(User user) : super(UserState(user: user));

  void updateBalance(double balance) {
    emit(UserState(user: state.user.copyWith(balance: balance)));
  }

  void addToBalance(double amount) {
    emit(
      UserState(
          user: state.user.copyWith(
        balance: state.user.balance + amount,
      )),
    );
  }

  void subtractFromBalance(double amount) {
    emit(
      UserState(
          user: state.user.copyWith(
        balance: state.user.balance - amount,
      )),
    );
  }
}

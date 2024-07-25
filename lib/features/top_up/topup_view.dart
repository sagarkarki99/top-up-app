import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_up_app/core/service_locator.dart';
import 'package:top_up_app/features/top_up/cubit/topup_cubit.dart';
import 'package:top_up_app/features/top_up/service/topup_service.dart';
import 'package:top_up_app/features/top_up/widgets/widgets.dart';
import 'package:top_up_app/features/users/cubit/user_cubit.dart';
import 'package:top_up_app/features/users/domain/user.dart';

class TopupView extends StatelessWidget {
  const TopupView({super.key, required this.beneficiaryId});

  final String beneficiaryId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TopupCubit(
        beneficiaryId: beneficiaryId,
        user: context.read<UserCubit>().state.user,
        topupService: locator.get<TopupService>(),
      ),
      child: const TopupBody(),
    );
  }
}

class TopupBody extends StatelessWidget {
  const TopupBody({super.key});

  @override
  Widget build(BuildContext context) {
    final User user = context.watch<UserCubit>().state.user;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 16, bottom: 16),
            color: Colors.grey[200],
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.3,
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(user.name.toString()),
                  Text(
                    user.balance.toString(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Top up to: Vikky'),
          const AmountField(),
          const SizedBox(height: 16),
          const DefaultAmountChips(),
          const Spacer(),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Top up'),
          ),
        ],
      ),
    );
  }
}

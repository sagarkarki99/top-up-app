import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_up_app/features/beneficiary/presentation/beneficiary_view.dart';
import 'package:top_up_app/features/users/cubit/user_cubit.dart';
import 'package:top_up_app/features/users/domain/user.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          _HeaderSection(),
          BeneficiaryView(),
        ],
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    final User user = context.watch<UserCubit>().state.user;
    return Container(
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
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_up_app/core/service_locator.dart';
import 'package:top_up_app/features/beneficiary/presentation/cubit/beneficiary_list_cubit.dart';
import 'package:top_up_app/features/beneficiary/presentation/widgets/beneficiary_item.dart';
import 'package:top_up_app/features/beneficiary/service/beneficiary_service.dart';
import 'package:top_up_app/features/top_up/topup_view.dart';
import 'package:top_up_app/features/users/cubit/user_cubit.dart';
import 'package:top_up_app/features/users/domain/user.dart';

class BeneficiaryView extends StatelessWidget {
  const BeneficiaryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BeneficiaryListCubit(
        user: context.read<UserCubit>().state.user,
        beneficiaryService: locator.get<BeneficiaryService>(),
      )..fetchBeneficiaries(),
      child: Scaffold(
        body: BlocBuilder<BeneficiaryListCubit, BeneficiaryListState>(
          builder: (context, state) => state.status.when(
            error: (errorMessage) => Center(child: Text(errorMessage)),
            empty: (_) => const _EmptyView(),
            fetching: () => const CircularProgressIndicator(),
            loaded: () => const _BeneficiaryListView(),
          ),
        ),
      ),
    );
  }
}

class _BeneficiaryListView extends StatelessWidget {
  const _BeneficiaryListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final beneficiaries =
        context.watch<BeneficiaryListCubit>().state.beneficiaries;
    return Column(
      children: [
        const _HeaderSection(),
        Container(
          color: Colors.grey[200],
          height: 180,
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            scrollDirection: Axis.horizontal,
            itemCount: beneficiaries.length,
            itemBuilder: (context, index) => BeneficiaryItem(
              beneficiary: beneficiaries[index],
              onRechargePressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) =>
                      TopupView(beneficiaryId: beneficiaries[index].id),
                );
              },
            ),
          ),
        ),
      ],
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

class _EmptyView extends StatelessWidget {
  const _EmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('No beneficiaries found.'),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_up_app/core/service_locator.dart';
import 'package:top_up_app/features/beneficiary/presentation/cubit/beneficiary_list_cubit.dart';
import 'package:top_up_app/features/beneficiary/presentation/widgets/widgets.dart';
import 'package:top_up_app/features/beneficiary/service/beneficiary_service.dart';
import 'package:top_up_app/features/top_up/topup_view.dart';
import 'package:top_up_app/features/users/cubit/user_cubit.dart';

class BeneficiaryView extends StatelessWidget {
  const BeneficiaryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BeneficiaryListCubit(
        user: context.read<UserCubit>().state.user,
        beneficiaryService: locator.get<BeneficiaryService>(),
      )..fetchBeneficiaries(),
      child: BlocBuilder<BeneficiaryListCubit, BeneficiaryListState>(
        builder: (context, state) {
          if (state.beneficiaries.isNotEmpty) {
            return const _BeneficiaryListView();
          }
          return state.status.when(
            error: (errorMessage) => Center(child: Text(errorMessage)),
            empty: (_) => const _EmptyView(),
            fetching: () => const CircularProgressIndicator(),
            loaded: () => const _BeneficiaryListView(),
          );
        },
      ),
    );
  }
}

class _BeneficiaryListView extends StatelessWidget {
  const _BeneficiaryListView();

  @override
  Widget build(BuildContext context) {
    final beneficiaries =
        context.watch<BeneficiaryListCubit>().state.beneficiaries;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Text(
                'Beneficiaries',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              beneficiaries.length < 5
                  ? IconButton(
                      onPressed: () => showModalBottomSheet(
                            context: context,
                            builder: (ctx) => BlocProvider.value(
                              value: context.read<BeneficiaryListCubit>(),
                              child: const AddBeneficiaryView(),
                            ),
                          ),
                      icon: const Icon(Icons.add))
                  : const SizedBox()
            ],
          ),
        ),
        const SizedBox(height: 8),
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

class _EmptyView extends StatelessWidget {
  const _EmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text('No beneficiaries found.'),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (ctx) => BlocProvider.value(
                value: context.read<BeneficiaryListCubit>(),
                child: const AddBeneficiaryView(),
              ),
            ),
            child: const Text('Add Beneficiary'),
          ),
        ],
      ),
    );
  }
}

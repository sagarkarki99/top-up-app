import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_up_app/core/service_locator.dart';
import 'package:top_up_app/features/beneficiary/presentation/cubit/beneficiary_list_cubit.dart';
import 'package:top_up_app/features/beneficiary/presentation/widgets/beneficiary_item.dart';
import 'package:top_up_app/features/beneficiary/service/beneficiary_service.dart';
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
      child: Scaffold(
        body: BlocBuilder<BeneficiaryListCubit, BeneficiaryListState>(
          builder: (context, state) => state.when(
            error: (errorMessage) => Center(child: Text(errorMessage)),
            empty: (_) => const CircularProgressIndicator(),
            fetching: () => const CircularProgressIndicator(),
            loaded: (list) => Center(
              child: Container(
                color: Colors.grey[200],
                height: 180,
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  scrollDirection: Axis.horizontal,
                  itemCount: list.length,
                  itemBuilder: (context, index) => BeneficiaryItem(
                    beneficiary: list[index],
                    onRechargePressed: () {},
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:top_up_app/core/service_locator.dart';
import 'package:top_up_app/features/top_up/cubit/topup_cubit.dart';
import 'package:top_up_app/features/top_up/service/topup_service.dart';
import 'package:top_up_app/features/top_up/widgets/widgets.dart';
import 'package:top_up_app/features/users/cubit/user_cubit.dart';

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
      )..setupTopupEnvironment(),
      child: const _TopupBody(),
    );
  }
}

class _TopupBody extends StatelessWidget {
  const _TopupBody();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TopupCubit, TopupState>(
      listener: (context, state) {
        if (state.topupStatus is ToppingUp) {
          context
              .read<UserCubit>()
              .subtractFromBalance(state.finalSendingAmount!);
        } else if (state.topupStatus is TopupFailed) {
          context.read<UserCubit>().addToBalance(state.finalSendingAmount!);
        }
      },
      builder: (context, state) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: state.topupInfoStatus.when(
            settingUp: () => const Center(child: CircularProgressIndicator()),
            setupFailed: (errorMessage) => Center(
              child: Text(errorMessage),
            ),
            loaded: () => const _TopupForm(),
          ),
        );
      },
    );
  }
}

class _TopupForm extends StatelessWidget {
  const _TopupForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopupCubit, TopupState>(
      builder: (context, state) {
        return state.topupStatus.maybeWhen(
          topupSuccess: (_) => const TopupSuccessView(),
          orElse: () => Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Top up: ${state.beneficiaryTopupInfo!.beneficiaryName}',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                const DefaultAmountChips(),
                const SizedBox(height: 16),
                Text(
                  state.validationMessage,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.red),
                ),
                const Spacer(),
                Text(
                  'AED ${state.beneficiaryTopupInfo!.fee.toInt()} will be charged for each transaction.',
                  style: const TextStyle(
                      fontSize: 12, fontStyle: FontStyle.italic),
                ),
                state.finalSendingAmount != null
                    ? Text('Total: AED ${state.finalSendingAmount}')
                    : const SizedBox.shrink(),
                Container(
                  padding: const EdgeInsets.all(8),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: state.topupStatus is ReadyToTopup
                        ? () => context.read<TopupCubit>().confirmTopup()
                        : null,
                    child: state.topupStatus is ToppingUp
                        ? LoadingAnimationWidget.horizontalRotatingDots(
                            color: Colors.blueAccent,
                            size: 48,
                          )
                        : const Text('Top up'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class TopupSuccessView extends StatelessWidget {
  const TopupSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.airplane_ticket_sharp, size: 108),
          const SizedBox(height: 16),
          Text(
            'Topup successful!',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(8),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Okay'),
            ),
          )
        ],
      ),
    );
  }
}

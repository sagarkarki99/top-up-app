import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_up_app/features/top_up/cubit/topup_cubit.dart';

class DefaultAmountChips extends StatelessWidget {
  const DefaultAmountChips({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 4.0,
      spacing: 8.0,
      children: context
          .read<TopupCubit>()
          .state
          .topupOptions
          .map((amount) => _ChipItem(
              label: 'AED ${amount.toInt()}',
              isSelected: context.watch<TopupCubit>().state.selected == amount,
              onTap: () => context.read<TopupCubit>().updateSelection(amount)))
          .toList(),
    );
  }
}

class _ChipItem extends StatelessWidget {
  const _ChipItem({
    required this.label,
    this.isSelected = false,
    this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey[500] : Colors.white,
          border: Border.all(
            color: isSelected ? Colors.blueGrey : Colors.blueGrey,
          ),
          borderRadius: BorderRadius.circular(
            16,
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 08,
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: isSelected ? Colors.white : Colors.black87,
              ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

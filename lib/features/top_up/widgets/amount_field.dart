import 'package:flutter/material.dart';

class AmountField extends StatelessWidget {
  const AmountField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: const InputDecoration(
        labelText: 'Amount',
      ),
    );
  }
}

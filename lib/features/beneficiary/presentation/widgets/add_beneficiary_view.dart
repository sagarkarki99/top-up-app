import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_up_app/features/beneficiary/domain/beneficiary.dart';
import 'package:top_up_app/features/beneficiary/presentation/cubit/beneficiary_list_cubit.dart';

class AddBeneficiaryView extends StatefulWidget {
  const AddBeneficiaryView({super.key});

  @override
  State<AddBeneficiaryView> createState() => AddBeneficiaryViewState();
}

class AddBeneficiaryViewState extends State<AddBeneficiaryView> {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneNumberController;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _nameController = TextEditingController();
    _phoneNumberController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BeneficiaryListCubit, BeneficiaryListState>(
      listener: (context, state) {
        state.status.maybeWhen(
          loaded: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Beneficiary added!'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context);
          },
          orElse: () {},
        );
      },
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            16,
            16,
            16,
            MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                onChanged: (_) => setState(() {}),
                validator: (value) {
                  if (value == null) return 'Name is required';
                  if (value.length > 20) {
                    return 'Maximum character should not be more than 20.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _phoneNumberController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                onChanged: (_) => setState(() {}),
                validator: (value) {
                  if (value == null ||
                      !value.startsWith('+') ||
                      value.length > 11) {
                    return 'Invalid format. eg: +1111111111';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 8),
              if (context.watch<BeneficiaryListCubit>().state.status is Error)
                Text(
                  (context.watch<BeneficiaryListCubit>().state.status as Error)
                      .errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _nameController.text.trim().isNotEmpty &&
                        _phoneNumberController.text.trim().isNotEmpty
                    ? () => _add(context)
                    : null,
                child: const Text('Add Beneficiary'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _add(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    context.read<BeneficiaryListCubit>().addBeneficiary(
          Beneficiary(
            name: _nameController.text.trim(),
            phoneNumber: _phoneNumberController.text.trim(),
            id: '',
          ),
        );
  }
}

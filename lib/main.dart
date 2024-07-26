import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_up_app/features/beneficiary/presentation/beneficiary_view.dart';
import 'package:top_up_app/core/service_locator.dart';
import 'package:top_up_app/features/users/cubit/user_cubit.dart';
import 'package:top_up_app/features/users/domain/user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(
        User(
          id: '1',
          name: 'Sagar',
          balance: 50.25,
        ),
      ),
      child: MaterialApp(
        title: 'Top-up App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const BeneficiaryView(),
      ),
    );
  }
}

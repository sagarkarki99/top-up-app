import 'package:get_it/get_it.dart';
import 'package:top_up_app/features/beneficiary/service/beneficiary_service.dart';
import 'package:top_up_app/features/beneficiary/service/beneficiary_service_impl.dart';

final locator = GetIt.instance;

Future<void> initializeServiceLocator() async {
  locator.registerSingleton<BeneficiaryService>(MockBeneficiaryServiceImpl());
  await locator.allReady();
}

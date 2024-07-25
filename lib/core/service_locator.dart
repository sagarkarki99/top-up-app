import 'package:get_it/get_it.dart';
import 'package:top_up_app/features/beneficiary/service/beneficiary_service.dart';
import 'package:top_up_app/features/beneficiary/service/beneficiary_service_impl.dart';
import 'package:top_up_app/features/top_up/service/mock_topup_service.dart';

final locator = GetIt.instance;

Future<void> initializeServiceLocator() async {
  locator.registerSingleton<BeneficiaryService>(MockBeneficiaryServiceImpl());
  locator.registerSingleton<MockTopupService>(MockTopupService());
  await locator.allReady();
}

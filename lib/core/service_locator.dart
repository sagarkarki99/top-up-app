import 'package:get_it/get_it.dart';
import 'package:top_up_app/features/beneficiary/service/beneficiary_service.dart';
import 'package:top_up_app/features/top_up/service/mock_data_store.dart';
import 'package:top_up_app/features/top_up/service/topup_service.dart';

final locator = GetIt.instance;

Future<void> initializeServiceLocator() async {
  locator.registerLazySingleton<MockDataStore>(() => MockDataStore());
  locator.registerLazySingleton<BeneficiaryService>(
      () => locator<MockDataStore>());
  locator.registerLazySingleton<TopupService>(() => locator<MockDataStore>());
  await locator.allReady();
}

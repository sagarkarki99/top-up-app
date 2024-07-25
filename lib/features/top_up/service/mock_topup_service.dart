import 'package:top_up_app/features/top_up/entity/topup_info.dart';
import 'package:top_up_app/features/top_up/service/topup_service.dart';

class MockTopupService implements TopupService {
  @override
  Future<TopupInfo> fetchTopupInfo(String userId, String beneficiaryId) async {
    return Future.delayed(const Duration(seconds: 1), () {
      return TopupInfo(
        id: '43',
        beneficiaryName: 'Radhe Radhe',
        beneficiaryPhoneNumber: '234234234',
        fee: 1,
        totalToppedupAmount: BalanceInfo(allowed: 1000, available: 1000),
        beneficiaryToppedupAmount: BalanceInfo(allowed: 1000, available: 1000),
      );
    });
  }

  @override
  Future<void> topup(String userId, String beneficiaryId, double amount) async {
    Future.value();
  }
}

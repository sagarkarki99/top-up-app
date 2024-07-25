import 'package:top_up_app/features/top_up/service/topup_service.dart';

class MockTopupService implements TopupService {
  @override
  Future<String> fetchTopupInfo(String userId, String beneficiaryId) async {
    return 'hehe';
  }

  @override
  Future<void> topup(String userId, String beneficiaryId, double amount) async {
    Future.value();
  }
}

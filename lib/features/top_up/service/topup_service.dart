import 'package:top_up_app/features/top_up/entity/topup_info.dart';

abstract class TopupService {
  Future<TopupInfo> fetchTopupInfo(String userId, String beneficiaryId);
  Future<void> topup(String userId, String beneficiaryId, double amount);
}

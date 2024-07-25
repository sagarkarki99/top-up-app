import 'package:top_up_app/features/top_up/entity/topup_info.dart';
import 'package:top_up_app/features/top_up/entity/topup_success_entity.dart';

abstract class TopupService {
  Future<TopupInfo> fetchTopupInfo(String userId, String beneficiaryId);
  Future<TopupSuccessEntity> topup(
    String userId,
    String beneficiaryId,
    double amount,
  );
}

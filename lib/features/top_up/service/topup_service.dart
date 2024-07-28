import 'package:top_up_app/features/top_up/entity/topup_info.dart';
import 'package:top_up_app/features/top_up/entity/topup_success_entity.dart';

/// Service that acts as Interface to application for handling topup related operations.
abstract class TopupService {
  /// Fetches the topup information for the user's beneficiary.
  Future<TopupInfo> fetchTopupInfo(String userId, String beneficiaryId);

  /// Initiates the topup process.
  Future<TopupSuccessEntity> topup(
    String userId,
    String beneficiaryId,
    double amount,
  );
}

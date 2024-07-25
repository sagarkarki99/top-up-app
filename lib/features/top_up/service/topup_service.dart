abstract class TopupService {
  Future<String> fetchTopupInfo(String userId, String beneficiaryId);
  Future<void> topup(String userId, String beneficiaryId, double amount);
}

import 'package:top_up_app/features/beneficiary/domain/beneficiary.dart';

abstract class BeneficiaryService {
  Future<Beneficiary> addNewBeneficiary(
    String userId,
    Beneficiary newBeneficiary,
  );

  Future<List<Beneficiary>> fetchBeneficiaries(String userId);
}

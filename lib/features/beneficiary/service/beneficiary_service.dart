import 'package:top_up_app/features/beneficiary/domain/beneficiary.dart';

/// Service that acts as Interface to application for handling beneficiary related operations.
abstract class BeneficiaryService {
  /// Adds a new beneficiary to the user's list of beneficiaries.
  Future<Beneficiary> addNewBeneficiary(
    String userId,
    Beneficiary newBeneficiary,
  );

  /// Fetches the list of beneficiaries for the user.
  Future<List<Beneficiary>> fetchBeneficiaries(String userId);
}

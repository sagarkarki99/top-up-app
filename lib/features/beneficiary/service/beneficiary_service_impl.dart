import 'package:top_up_app/features/beneficiary/domain/beneficiary.dart';
import 'package:top_up_app/features/beneficiary/service/beneficiary_service.dart';

class MockBeneficiaryServiceImpl implements BeneficiaryService {
  @override
  Future<Beneficiary> addNewBeneficiary(
      String userId, Beneficiary newBeneficiary) {
    return Future.value(
      Beneficiary(id: 'test', name: 'Test', phoneNumber: '234234'),
    );
  }

  @override
  Future<List<Beneficiary>> fetchBeneficiaries(String userId) {
    return Future.value([
      Beneficiary(
        id: 'test',
        name: 'Test',
        phoneNumber: '234234',
      )
    ]);
  }
}

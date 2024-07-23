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
        name: 'Amit Pahandit',
        phoneNumber: '+975255219205',
      ),
      Beneficiary(
        id: 'test',
        name: 'Kumar Suresh',
        phoneNumber: '+975445454545',
      ),
      Beneficiary(
        id: 'test',
        name: 'Amit Pahandit',
        phoneNumber: '+887897465413',
      ),
      Beneficiary(
        id: 'test',
        name: 'Snoop Dog',
        phoneNumber: '545454545454',
      ),
    ]);
  }
}

import 'package:top_up_app/features/beneficiary/domain/beneficiary.dart';
import 'package:top_up_app/features/beneficiary/service/beneficiary_service.dart';
import 'package:top_up_app/features/top_up/entity/topup_info.dart';
import 'package:top_up_app/features/top_up/entity/topup_success_entity.dart';
import 'package:top_up_app/features/top_up/service/topup_service.dart';

class MockDataStore implements TopupService, BeneficiaryService {
  final List<Beneficiary> beneficiaries = [
    Beneficiary(
      id: '1',
      name: 'Amit Pahandit',
      phoneNumber: '+975255219205',
    ),
    Beneficiary(
      id: '2',
      name: 'Kumar Suresh',
      phoneNumber: '+975445454545',
    ),
    Beneficiary(
      id: '3',
      name: 'Amit Pahandit',
      phoneNumber: '+887897465413',
    ),
    Beneficiary(
      id: '4',
      name: 'Snoop Dog',
      phoneNumber: '545454545454',
    ),
  ];

  static const double maxLimitForVerifiedUser = 1000;
  static const double maxLimitForUnVerifiedUser = 500;
  static const double totalAllowedAmount = 3000;

  @override
  Future<Beneficiary> addNewBeneficiary(
      String userId, Beneficiary newBeneficiary) async {
    return Future.value(beneficiaries.first);
  }

  @override
  Future<List<Beneficiary>> fetchBeneficiaries(String userId) {
    return Future.value(beneficiaries);
  }

  @override
  Future<TopupInfo> fetchTopupInfo(String userId, String beneficiaryId) {
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
  Future<TopupSuccessEntity> topup(
      String userId, String beneficiaryId, double amount) {
    return Future.value(
        TopupSuccessEntity(message: 'Success', transactionId: '123'));
  }
}

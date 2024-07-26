import 'package:top_up_app/features/beneficiary/domain/beneficiary.dart';
import 'package:top_up_app/features/beneficiary/service/beneficiary_service.dart';
import 'package:top_up_app/features/top_up/entity/topup_info.dart';
import 'package:top_up_app/features/top_up/entity/topup_success_entity.dart';
import 'package:top_up_app/features/top_up/service/topup_service.dart';
import 'package:top_up_app/features/users/domain/user.dart';

class MockDataStore implements TopupService, BeneficiaryService {
  late User user;
  MockDataStore();

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

  final Map<String, BalanceInfo> beneficiaryIdToBalance = {
    '1': BalanceInfo(
      allowed: maxLimitForVerifiedUser,
      available: maxLimitForVerifiedUser,
    ),
    '2': BalanceInfo(
      allowed: maxLimitForVerifiedUser,
      available: maxLimitForVerifiedUser,
    ),
    '3': BalanceInfo(
      allowed: maxLimitForVerifiedUser,
      available: maxLimitForVerifiedUser,
    ),
    '4': BalanceInfo(
      allowed: maxLimitForVerifiedUser,
      available: maxLimitForVerifiedUser,
    ),
  };

  BalanceInfo usersLimit = BalanceInfo(allowed: 3000, available: 3000);

  static const double maxLimitForVerifiedUser = 1000;
  static const double maxLimitForUnVerifiedUser = 500;
  static const double totalAllowedAmount = 3000;
  static const double feePerTransaction = 1;

  setUser(User user) {
    this.user = user;
  }

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
    final beneficiary = beneficiaries.firstWhere(
      (element) => element.id == beneficiaryId,
    );
    return Future.delayed(const Duration(seconds: 1), () {
      return TopupInfo(
        id: '43',
        beneficiaryName: beneficiary.name,
        beneficiaryPhoneNumber: beneficiary.phoneNumber,
        fee: 1,
        totalToppedupAmount: usersLimit,
        beneficiaryToppedupAmount: beneficiaryIdToBalance[beneficiaryId]!,
      );
    });
  }

  @override
  Future<TopupSuccessEntity> topup(
      String userId, String beneficiaryId, double amount) {
    final beneficiaryBalance = beneficiaryIdToBalance[beneficiaryId]!;
    beneficiaryIdToBalance[beneficiaryId] = beneficiaryBalance.copyWith(
      available: beneficiaryBalance.available - amount,
    );
    usersLimit = usersLimit.copyWith(available: usersLimit.available - amount);
    print(beneficiaryBalance);
    print('-----------------');
    print(usersLimit);
    return Future.value(
        TopupSuccessEntity(message: 'Success', transactionId: '123'));
  }
}

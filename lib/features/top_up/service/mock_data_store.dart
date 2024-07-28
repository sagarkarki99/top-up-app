import 'package:top_up_app/features/beneficiary/domain/beneficiary.dart';
import 'package:top_up_app/features/beneficiary/service/beneficiary_service.dart';
import 'package:top_up_app/features/top_up/entity/topup_info.dart';
import 'package:top_up_app/features/top_up/entity/topup_success_entity.dart';
import 'package:top_up_app/features/top_up/service/topup_service.dart';
import 'package:top_up_app/features/users/domain/user.dart';

class MockDataStore implements TopupService, BeneficiaryService {
  late User user;
  MockDataStore() {
    user = User(
      id: '1',
      name: 'Sagar',
      balance: 100,
    );
    beneficiaryIdToBalance = {
      '1': _getDefaultInfoForVerified(),
      '2': _getDefaultInfoForVerified(),
      '3': _getDefaultInfoForVerified(),
      '4': _getDefaultInfoForVerified(),
    };
    beneficiaries = [
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
  }

  static const double maxLimitForVerifiedUser = 70;
  static const double maxLimitForUnVerifiedUser = 50;
  static const double totalAllowedAmount = 100;
  static const double feePerTransaction = 1;

  late final List<Beneficiary> beneficiaries;

  late final Map<String, BalanceInfo> beneficiaryIdToBalance;
  DateTime? _lastTopupDate;

  BalanceInfo _getDefaultInfoForVerified() {
    return BalanceInfo(
      allowed: maxLimitForVerifiedUser,
      available: maxLimitForVerifiedUser,
    );
  }

  BalanceInfo usersLimit = BalanceInfo(
    allowed: totalAllowedAmount,
    available: totalAllowedAmount,
  );

  setUser(User user) {
    this.user = user;
  }

  @override
  Future<Beneficiary> addNewBeneficiary(
    String userId,
    Beneficiary newBeneficiary,
  ) async {
    return Future.value(newBeneficiary);
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
      final info = TopupInfo(
        id: '43',
        beneficiaryName: beneficiary.name,
        beneficiaryPhoneNumber: beneficiary.phoneNumber,
        fee: 1,
        totalToppedupAmount: _getUserLimitForCurrentMonth,
        beneficiaryToppedupAmount: beneficiaryIdToBalance[beneficiaryId]!,
      );
      return info;
    });
  }

  BalanceInfo get _getUserLimitForCurrentMonth {
    if (_lastTopupDate?.month == DateTime.now().month) {
      return usersLimit;
    }
    usersLimit = BalanceInfo(
      allowed: totalAllowedAmount,
      available: totalAllowedAmount,
    );
    return usersLimit;
  }

  @override
  Future<TopupSuccessEntity> topup(
    String userId,
    String beneficiaryId,
    double amount,
  ) {
    final beneficiaryBalance = beneficiaryIdToBalance[beneficiaryId]!;
    beneficiaryIdToBalance[beneficiaryId] = beneficiaryBalance.copyWith(
      available: beneficiaryBalance.available - amount,
    );
    usersLimit = usersLimit.copyWith(available: usersLimit.available - amount);
    user = user.copyWith(balance: user.balance - amount);
    _lastTopupDate = DateTime.now();
    print(beneficiaryBalance);
    print('-----------------');
    print(usersLimit);
    return Future.delayed(
      const Duration(seconds: 1),
      () => TopupSuccessEntity(
        message: 'Success',
        transactionId: '123',
      ),
    );
  }
}

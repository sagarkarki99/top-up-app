import 'dart:math';

import 'package:top_up_app/features/beneficiary/domain/beneficiary.dart';
import 'package:top_up_app/features/beneficiary/service/beneficiary_service.dart';
import 'package:top_up_app/features/top_up/entity/topup_info.dart';
import 'package:top_up_app/features/top_up/entity/topup_success_entity.dart';
import 'package:top_up_app/features/top_up/service/topup_service.dart';
import 'package:top_up_app/features/users/domain/user.dart';

class MockDataStore implements TopupService, BeneficiaryService {
  late User user;
  MockDataStore() {
    usersLimit = BalanceInfo(
      allowed: totalAllowedAmount,
      available: totalAllowedAmount,
    );
    user = User(
      id: '1',
      name: 'Sagar',
      balance: 100,
      isVerified: true,
    );
    beneficiaryIdToBalance = {
      '1': _getLimitInfo(),
      '2': _getLimitInfo(),
      '3': _getLimitInfo(),
      '4': _getLimitInfo(),
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
        phoneNumber: '+975255219205',
      ),
    ];
  }

  static const double maxLimitForVerifiedUser = 1000;
  static const double maxLimitForUnVerifiedUser = 500;
  static const double totalAllowedAmount = 3000;
  static const double feePerTransaction = 1;

  /// Stores the list of beneficiaries for the user.
  late final List<Beneficiary> beneficiaries;

  /// Stores the balance information for each beneficiary.
  late final Map<String, BalanceInfo> beneficiaryIdToBalance;

  /// Stores the user limit for the current month.
  late BalanceInfo usersLimit;

  /// Stores the last topupdate for any beneficiaries.
  /// This is used to reset the user total topup limit for the next month.
  DateTime? _lastTopupDate;

  BalanceInfo _getLimitInfo() {
    return user.isVerified
        ? BalanceInfo(
            allowed: maxLimitForVerifiedUser,
            available: maxLimitForVerifiedUser,
          )
        : BalanceInfo(
            allowed: maxLimitForUnVerifiedUser,
            available: maxLimitForUnVerifiedUser,
          );
  }

  @override
  Future<Beneficiary> addNewBeneficiary(
    String userId,
    Beneficiary newBeneficiary,
  ) async {
    final newValue = newBeneficiary.copyWith(
      id: _getRandomId(),
    );
    beneficiaryIdToBalance[newValue.id] = _getLimitInfo();
    beneficiaries.insert(0, newValue);
    return Future.value(newValue);
  }

  String _getRandomId() => (Random().nextInt(100) + 50).toString();

  @override
  Future<List<Beneficiary>> fetchBeneficiaries(String userId) {
    return Future.value(List.of(beneficiaries));
  }

  @override
  Future<TopupInfo> fetchTopupInfo(String userId, String beneficiaryId) {
    final beneficiary = beneficiaries.firstWhere(
      (element) => element.id == beneficiaryId,
    );
    return Future.delayed(const Duration(seconds: 1), () {
      return TopupInfo(
        id: _getRandomId(),
        beneficiaryName: beneficiary.name,
        beneficiaryPhoneNumber: beneficiary.phoneNumber,
        fee: feePerTransaction,
        totalToppedupAmount: _getUserLimitForCurrentMonth,
        beneficiaryToppedupAmount: beneficiaryIdToBalance[beneficiaryId]!,
      );
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

    return Future.delayed(
      const Duration(seconds: 1),
      () => TopupSuccessEntity(
        message: 'Success',
        transactionId: _getRandomId(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:top_up_app/features/beneficiary/domain/beneficiary.dart';

/// A widget that displays beneficiary information and allows recharging.
class BeneficiaryItem extends StatelessWidget {
  /// The beneficiary for which the card is displayed.
  final Beneficiary beneficiary;

  final VoidCallback onRechargePressed;

  /// Constructs a [BeneficiaryItem] with the specified [beneficiary] and [user].
  const BeneficiaryItem({
    super.key,
    required this.beneficiary,
    required this.onRechargePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(16),
      ),
      width: MediaQuery.of(context).size.width * 0.4,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              beneficiary.name,
              style: TextStyle(
                color: Colors.blue[700],
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              beneficiary.phoneNumber,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            ElevatedButton(
              onPressed: onRechargePressed,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                backgroundColor: Colors.blue[700],
              ),
              child: const Text(
                'Recharge Now',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

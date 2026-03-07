import 'package:untitled1/core/modules/transaction_modules/transaction_catagory.dart';

class ForRent extends TransactionCatagory {
  final double leasePrice;
  final double rentPrice;
  final int rentDuration;

  ForRent({
    required this.leasePrice,
    required this.rentPrice,
    required this.rentDuration,
  });
}

import 'package:untitled1/core/modules/transaction_modules/transaction_catagory.dart';

class ForSale extends TransactionCatagory {
  final double buyPrice;
  final double sellPrice;

  ForSale({required this.buyPrice, required this.sellPrice});
}

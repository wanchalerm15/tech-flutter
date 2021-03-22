import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/models/TransactionModel.dart';

class TransactionStore with ChangeNotifier {
  /// transaction items
  List<TransactionModel> _transactions = [];

  /// Get items
  List<TransactionModel> getItems() {
    _transactions.sort((a, b) => b.date.compareTo(a.date));
    return _transactions;
  }

  /// Create item
  void createItem(String title, double amount) {
    _transactions.add(TransactionModel(title: title, amount: amount));
    this.notifyListeners();
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/database/TransactionDB.dart';
import 'package:flutter_application_1/models/TransactionModel.dart';

class TransactionStore with ChangeNotifier {
  final database = TransactionDB(dbName: "transaction.db");

  /// transaction items
  List<TransactionModel> _transactions = [];

  /// Get items
  List<TransactionModel> getItems() {
    return _transactions;
  }

  /// Create item
  void createItem(String title, double amount) async {
    final model = TransactionModel(title: title, amount: amount);
    await database.insert(model);
    _transactions = await database.selectAll();
    // _transactions.add(TransactionModel(title: title, amount: amount));
    this.notifyListeners();
  }

  void initializeLoadData() async {
    _transactions = await database.selectAll();
    this.notifyListeners();
  }
}

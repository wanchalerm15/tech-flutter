import 'package:flutter_application_1/models/TransactionModel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class TransactionDB {
  final store = intMapStoreFactory.store("transaction_store");
  String dbName;

  TransactionDB({this.dbName});

  Future<Database> openDatabase() async {
    var appDirectory = await getApplicationDocumentsDirectory();
    var dbLocation = join(appDirectory.path, dbName);
    return databaseFactoryIo.openDatabase(dbLocation);
  }

  Future<List<TransactionModel>> selectAll() async {
    var db = await this.openDatabase();
    var snapshot = await store.find(db,
        finder: Finder(sortOrders: [
          SortOrder("date", false),
        ]));
    return snapshot
        .map(
          (e) => TransactionModel(
            title: e.value['title'],
            amount: e.value['amount'],
            date: DateTime.parse(e.value['date']),
          ),
        )
        .toList();
  }

  Future<int> insert(TransactionModel model) async {
    var db = await this.openDatabase();
    Map<String, Object> item = {
      "title": model.title,
      "amount": model.amount,
      "date": model.date.toString()
    };
    int add = await store.add(db, item);
    db.close();
    return add;
  }
}

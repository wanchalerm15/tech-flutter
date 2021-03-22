class TransactionModel {
  String title;
  double amount;
  DateTime date;

  TransactionModel({this.title, this.amount}) {
    this.date = DateTime.now();
  }
}

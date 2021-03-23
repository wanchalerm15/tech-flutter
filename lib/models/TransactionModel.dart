class TransactionModel {
  String title;
  double amount;
  DateTime date;

  TransactionModel({this.title, this.amount, this.date}) {
    this.date = this.date ?? DateTime.now();
  }
}

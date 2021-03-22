import 'package:flutter/material.dart';
import 'package:flutter_application_1/stores/TransactionStore.dart';
import 'package:provider/provider.dart';

class FormScreen extends StatelessWidget {
  final form = GlobalKey<FormState>();
  final titleForm = TextEditingController();
  final amountForm = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("แบบฟอร์มบันทึกข้อมูล"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: titleForm,
                decoration: InputDecoration(labelText: "ชื่อรายการ"),
                autofocus: true,
                validator: (String str) {
                  return str.isEmpty ? "กรุณาป้อนข้อมูล" : null;
                },
              ),
              TextFormField(
                controller: amountForm,
                decoration: InputDecoration(labelText: "จำนวนเงิน"),
                keyboardType: TextInputType.number,
                validator: (String str) {
                  if (str.isEmpty) return "กรุณาป้อนข้อมูล";
                  if (double.parse(str) <= 0) return "กรุณาป้อนตัวเลขมากกว่า 0";
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_box),
                    SizedBox(width: 5),
                    Text("เพิ่มข้อมูล"),
                  ],
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  primary: Colors.white,
                ),
                onPressed: () {
                  if (form.currentState.validate()) {
                    final store = Provider.of<TransactionStore>(
                      context,
                      listen: false,
                    );
                    store.createItem(
                      titleForm.text,
                      double.parse(amountForm.text),
                    );
                    Navigator.pop(context);
                  } else {
                    print("Invalid");
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

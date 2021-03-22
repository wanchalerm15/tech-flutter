import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/FormScreen.dart';
import 'package:flutter_application_1/stores/TransactionStore.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TransactionStore()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'แอพบัญชี'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return FormScreen();
              }));
            },
          )
        ],
      ),
      body: Consumer(
        builder: (context, TransactionStore store, Widget child) {
          var items = store.getItems();
          var count = items.length;
          if (count <= 0) {
            return Center(
              child: Text("ไม่พบข้อมูล !", style: TextStyle(fontSize: 20)),
            );
          }
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, int index) {
              var item = items[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: FittedBox(
                      child: Text(
                        NumberFormat("#,###.##").format(item.amount),
                      ),
                    ),
                  ),
                  title: Text(item.title),
                  subtitle: Text(
                    DateFormat("dd/MM/yyyy HH:mm:ss").format(item.date),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

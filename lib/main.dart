import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Лабараторна робота 5',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StringProcessingHomePage(title: 'Обробка рядка'),
    );
  }
}

class StringProcessingHomePage extends StatefulWidget {
  const StringProcessingHomePage({super.key, required this.title});

  final String title;

  @override
  State<StringProcessingHomePage> createState() => _StringProcessingHomePageState();
}

class _StringProcessingHomePageState extends State<StringProcessingHomePage> {

  String redactedText = "";
  List<String> processingOptions = <String>['Почергово маленькі та великі літери',
    'Замінити всі букви "а" рядка на букви "о"'];
  late String dropdownValue = processingOptions.first;
  final content = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 16,right: 4,bottom: 8,left: 4),
              child: Text(
                'Виберіть варіант обробки рядк',
                style: TextStyle(fontSize: 22.0),
                textAlign: TextAlign.center,
              ),
            ),
            DropdownButton<String>(
              style: const TextStyle(fontSize: 16.0, color: Colors.black),
              value: dropdownValue,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              underline: Container(
                height: 2,
                color: Colors.black,
              ),
              onChanged: (String? value) {
                setState(() {
                  dropdownValue = value!;
                });
              },
              items: processingOptions.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5,right: 8,bottom: 8,left: 8),
              child: TextField(
                controller: content,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Введіть рядок',
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                setState((){
                  redactedText = processingRow(dropdownValue, content.text);
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                      ResultScreen(redactedText: redactedText)));
                });
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue,
              ),
              child: const Text('Обробити',
                style: TextStyle(fontSize: 22.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String processingRow(String processingOption, String row) {
    String redactedRow = "";
    if(processingOption == processingOptions.first) {
      String lower = "";
      String upper = "";

      for (int i = 0; i < row.length; i+=2) {
        lower += row[i];
      }

      for (int i = 1; i < row.length; i+=2) {
        upper += row[i];
      }

      lower = lower.toLowerCase();
      upper = upper.toUpperCase();

      for (int i = 0; i < lower.length; i++) {
        redactedRow += lower[i];
        if(upper.length > i) {
          redactedRow += upper[i];
        }
      }
      return redactedRow;
    }
    else {
      redactedRow = row.replaceAll('A', 'O');
      redactedRow = redactedRow.replaceAll('a', 'o');
      return redactedRow;
    }
  }
}

class ResultScreen extends StatelessWidget {

  String redactedText = "";

  ResultScreen({required this.redactedText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Результат')),
      body: Center(
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 96,right: 4,bottom: 20,left: 4),
              child: Text(
                'Результат обробки рядка:',
                style: TextStyle(fontSize: 22.0),
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              redactedText,
              style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
           ),
          ],
        ),
      ),
    );
  }
}
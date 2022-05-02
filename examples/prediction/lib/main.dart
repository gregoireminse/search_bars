import 'package:flutter/material.dart';
import 'package:search_bars/search_bars.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'Prediction Bar prediction'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: PredictionBar(
        decorationBar: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)),
        decorationTextInput: const InputDecoration(border: InputBorder.none, prefixIcon: Icon(Icons.search)),
        fetchSuggestions: (_) => ['Test', 0, 01110010],
        itemBuilder: (_, Function() __) => ListTile(title: Text(_.toString()), onTap: __),
        mainAxisAlignment: MainAxisAlignment.center,
        onSuggestionSelected: (_) {},
        validateButtonStyle: ElevatedButton.styleFrom(shape: const CircleBorder(), padding: const EdgeInsets.all(15)),
      ),
    );
  }
}

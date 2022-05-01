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
      body: PredictionBar<Object>(
        mainAxisAlignment: MainAxisAlignment.center,
        fetchSuggestions: (String _) => [],
        decorationBar: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
        decorationTextInput: const InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Color(0xFF9DD14B),
          ),
          border: InputBorder.none,
        ),
        onSuggestionSelected: (_) {},
        itemBuilder: (Object _) {
          return Text(_.toString());
        },
      ),
    );
  }
}

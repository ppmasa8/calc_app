import 'dart:async';
import 'package:flutter/material.dart';
import 'calc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextField(),
                Keyboard(),
              ],
            )
        )
    );
  }
}

// View
class TextField extends StatefulWidget {
  _TextFiledState createState() => _TextFiledState();
}

class _TextFiledState extends State<TextField> {
  String _expression = '';
  final integer = RegExp(r'^[\d||.]*$');

  void _UpdateText(String letter) {
    setState(() {
      if (letter == 'C') {
        _expression = '';
      } else if (letter == '◀') {
        if (_expression.substring(_expression.length - 1) == 'd')
          _expression = _expression.substring(0, _expression.length - 3);
        else
          _expression = _expression.substring(0, _expression.length - 1);
      }
      else if (letter == '=') {
        _expression = '';
        var result = Calculator.Execute();
        //TODO Add commma conditions
        var answer = '';
        if (integer.hasMatch(result)) {
          if (result.contains('.')) {
            answer = result;
          } else {
            answer = addComma(result);
          }
        } else {
          answer = result;
        }
        controller.sink.add(answer);
      } else if (letter == 'e') {
        _expression = 'Error';
      } else
        _expression += letter;
    });
  }

  String addComma(String str) {
    var arr = str.split('').reversed;
    var res = [];
    for (int i = 0; i < arr.length; i++) {
      if (i % 3 == 0 && i != 0) {
        res.add(",");
      }
      res.add(arr.elementAt(i));
    }
    return res.reversed.join();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Container(
         child: Align(
           alignment: Alignment.centerRight,
           child: Text(
             _expression,
             style: GoogleFonts.openSansCondensed(
                 fontSize: 64.0
             ),
           ),
         ),
        )
    );
  }

  static final controller = StreamController.broadcast();
  @override
  void initState() {
    controller.stream.listen((event) => _UpdateText(event));
    controller.stream.listen((event) => Calculator.GetKey(event));
  }
}

// Keyboard
class Keyboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Center(
        child: Container(
          color: Colors.cyan.shade50,
          child: GridView.count(
              crossAxisCount: 4,
              mainAxisSpacing: 3,
              crossAxisSpacing: 3,
              children: [
                'C', 'mod', '◀', '÷',
                '7', '8', '9', '×',
                '4', '5', '6', '-',
                '1', '2', '3', '+',
                '00', '0', '.', '='
              ].map((key) {
                return GridTile(
                    child: Button(key),
                );
              }).toList(),
          ),
        ),
      ),
    );
  }
}

// Button
const symbol = ['+', '-', '×', '÷', 'mod', 'C', '=', '◀'];
class Button extends StatelessWidget {
  final _key;
  Button(this._key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        onPressed: () {
          _TextFiledState.controller.sink.add(_key);
        },
        child: Center(
          child: Text(
            _key,
            style: GoogleFonts.anaheim(
                fontSize: 46,
                color: symbol.contains(_key) ? Colors.cyan : Colors.black
            ),
          ),
        ),
      ),
    );
  }
}

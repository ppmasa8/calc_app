// @dart=2.9

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'calc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(MyApp());
}

// advertisement
String getTestAdBannerUnitId(){
  String testBannerUnitId = "";
  if(Platform.isAndroid) {
    // Android
    testBannerUnitId = "ca-app-pub-9085522828855425/3017038868";
  } else if(Platform.isIOS) {
    // iOS
    testBannerUnitId = "ca-app-pub-3940256099942544/2934735716";
  }
  return testBannerUnitId;
}

class MyApp extends StatelessWidget {
  final BannerAd myBanner = BannerAd(
    adUnitId: getTestAdBannerUnitId(),
    size: AdSize.banner,
    request: AdRequest(),
    listener: AdListener(),
  );

  @override
  Widget build(BuildContext context) {
    myBanner.load();
    final AdWidget adWidget = AdWidget(ad: myBanner);

    final Container adContainer = Container(
      alignment: Alignment.center,
      child: adWidget,
      width: myBanner.size.width.toDouble(),
      height: myBanner.size.height.toDouble(),
    );
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextField(),
                Keyboard(),
                adContainer,
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
      // 3文字だと都合が悪いので1文字に圧縮
      if (letter == 'mod') {
        letter = '%';
      }
      _expression = _expression.replaceAll('mod', '%');

      if (letter == 'C') {
        _expression = '';
      } else if (letter == '◀') {
        if (_expression.substring(_expression.length - 1) == 'd')
          _expression = _expression.substring(0, _expression.length - 3);
        else
          _expression = _expression.substring(0, _expression.length - 1);

        // 数字にコンマをつける処理
        _expression = _expression.replaceAll(',', '');
        var splitList     = _expression.split('');
        var numAndOpSplit = [];
        var resList = [];
        var str = '';
        splitList.forEach((element) {
          if (operand.contains(element)) {
            numAndOpSplit.add(str);
            numAndOpSplit.add(element);
            str = '';
          } else {
            str += element;
          }
        });
        numAndOpSplit.add(str);

        numAndOpSplit.forEach((element) {
          if (operand.contains(element)) {
            resList.add(element);
          } else {
            if (element.contains('.')) {
              var num     = double.parse(element);
              var split   = num.toString().split(".");
              if (letter == ".") {
                element = addComma(split[0]) + ".";
              } else {
                element = addComma(split[0]) + "." + split[1];
              }
            } else {
              element = addComma(element);
            }
            resList.add(element);
          }
        });
        _expression = resList.join();
      } else if (letter == '=') {
        _expression = '';
        var result = Calculator.Execute();
        // 計算結果にコンマをつける処理
        var answer = '';
        if (integer.hasMatch(result)) {
          if (result.contains('.')) {
            var num     = double.parse(result);
            var split   = num.toString().split("");
            answer = addComma(split[0]) + "." + split[1];
          } else {
            answer = addComma(result);
          }
        } else {
          answer = result;
        }
        controller.sink.add(answer);
      } else if (letter == 'e') {
        _expression = 'Error';
      } else {
        _expression += letter;
        // 数字にコンマをつける処理
        _expression = _expression.replaceAll(',', '');
        var splitList     = _expression.split('');
        var numAndOpSplit = [];
        var resList = [];
        var str = '';
        splitList.forEach((element) {
          if (operand.contains(element)) {
            numAndOpSplit.add(str);
            numAndOpSplit.add(element);
            str = '';
          } else {
            str += element;
          }
        });
        numAndOpSplit.add(str);

        numAndOpSplit.forEach((element) {
          if (operand.contains(element)) {
            resList.add(element);
          } else {
            if (element.contains('.')) {
              var num     = double.parse(element);
              var split   = num.toString().split(".");
              if (letter == ".") {
                element = addComma(split[0]) + ".";
              } else {
                element = addComma(split[0]) + "." + split[1];
              }
            } else {
              element = addComma(element);
            }
            resList.add(element);
          }
        });
        _expression = resList.join();
      }
      // 圧縮した文字をもとに戻す
      _expression = _expression.replaceAll('%', 'mod');
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
        flex: 4,
        child: Container(
         child: Align(
           alignment: Alignment.centerRight,
           child: Text(
             _expression,
             style: GoogleFonts.openSansCondensed(
                 fontSize: _expression.length < 17 ? 64.0 : _expression.length < 25 ? 44.0 : 34.0
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
      flex: 9,
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

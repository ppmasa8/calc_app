import 'dart:math';
import 'package:calc_app/calc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Random random = new Random();
  int randomNumber = random.nextInt(100000000);
  test('Confirm that the addition is normal.', () {
    // Input integer or operand.
    String num1 = randomNumber.toString();
    String num2 = randomNumber.toString();

    Calculator.GetKey(num1);
    Calculator.GetKey('+');
    Calculator.GetKey(num2);

    var result = Calculator.Execute();
    expect(result, (int.parse(num1) + int.parse(num2)).toString());
  });

  test('Confirm that the subtraction is normal.', () {
    String num1 = randomNumber.toString();
    String num2 = randomNumber.toString();

    Calculator.GetKey(num1);
    Calculator.GetKey('-');
    Calculator.GetKey(num2);

    var result = Calculator.Execute();
    expect(result, (int.parse(num1) - int.parse(num2)).toString());
  });

  test('Confirm that the multiplication is normal.', () {
    String num1 = randomNumber.toString();
    String num2 = randomNumber.toString();

    Calculator.GetKey(num1);
    Calculator.GetKey('×');
    Calculator.GetKey(num2);

    var result = Calculator.Execute();
    expect(result, (int.parse(num1) * int.parse(num2)).toString());
  });
}

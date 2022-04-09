import 'dart:math';
import 'package:calc_app/calc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:decimal/decimal.dart';

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
    expect(result, (Decimal.parse(num1) + Decimal.parse(num2)).toString());
  });

  test('Confirm that the subtraction is normal.', () {
    String num1 = randomNumber.toString();
    String num2 = randomNumber.toString();

    Calculator.GetKey(num1);
    Calculator.GetKey('-');
    Calculator.GetKey(num2);

    var result = Calculator.Execute();
    expect(result, (Decimal.parse(num1) - Decimal.parse(num2)).toString());
  });

  test('Confirm that the multiplication is normal.', () {
    String num1 = randomNumber.toString();
    String num2 = randomNumber.toString();

    Calculator.GetKey(num1);
    Calculator.GetKey('×');
    Calculator.GetKey(num2);

    var result = Calculator.Execute();
    expect(result, (Decimal.parse(num1) * Decimal.parse(num2)).toString());
  });

  test('Confirm that the division is normal.', () {
    String num1 = randomNumber.toString();
    String num2 = randomNumber.toString();

    Calculator.GetKey(num1);
    Calculator.GetKey('÷');
    Calculator.GetKey(num2);

    var result = Calculator.Execute();
    expect(result, (Decimal.parse(num1) / Decimal.parse(num2)).toDecimal(scaleOnInfinitePrecision: 17).toString());
  });

  test('Confirm that the modulo arithmetic is normal.', () {
    String num1 = randomNumber.toString();
    String num2 = randomNumber.toString();

    Calculator.GetKey(num1);
    Calculator.GetKey('mod');
    Calculator.GetKey(num2);

    var result = Calculator.Execute();
    expect(result, (Decimal.parse(num1) % Decimal.parse(num2)).toString());
  });

  test('Complex calculations.', () {
    String num1 = randomNumber.toString();
    String num2 = randomNumber.toString();
    String num3 = randomNumber.toString();
    String num4 = randomNumber.toString();

    Calculator.GetKey(num1);
    Calculator.GetKey('×');
    Calculator.GetKey(num2);
    Calculator.GetKey('+');
    Calculator.GetKey(num3);
    // All clear
    Calculator.GetKey('C');
    Calculator.GetKey(num1);
    Calculator.GetKey('×');
    Calculator.GetKey(num2);
    Calculator.GetKey('÷');
    Calculator.GetKey('1');
    // Remove 1 character
    Calculator.GetKey('◀');
    Calculator.GetKey(num4);
    Calculator.GetKey('mod');
    Calculator.GetKey(num4);

    var result = Calculator.Execute();
    var calc = ((Decimal.parse(num1) * Decimal.parse(num2) / Decimal.parse(num4)).toDecimal(scaleOnInfinitePrecision: 17) % Decimal.parse(num4)).toString();
    expect(result, calc);
  });
}

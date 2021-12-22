const operand = ['+', '-', '×', '÷', 'mod'];

class Calculator {
  static var _list_number  = [];
  static var _list_operand = [];

  static var _buffer = '';

  static void GetKey(String letter) {
    if (operand.contains(letter)) {
      _list_operand.add(letter);
      _list_number.add(double.parse(_buffer));
      _buffer = '';
    }
    else if (letter == 'C') {
      _list_number.clear();
      _list_operand.clear();
      _buffer = '';
    }
    else if (letter == '=') {
      return null;
    }
    else
      _buffer += letter;
  }

  static String Execute() {
    var _result = 0.0;
    _list_number.add(double.parse(_buffer));

    if (_list_number.length == 0)
      return '0';

    _result += _list_number[0];
    _list_number.removeAt(0);
    for (int i = 0; i < _list_operand.length; i++) {
      if (_list_operand[i] == '+')
        _result += _list_number[0];
      else if (_list_operand[i] == '-')
        _result -= _list_number[0];
      else if (_list_operand[i] == '×')
        _result *= _list_number[0];
      else if (_list_operand[i] == '÷')
        _result /= _list_number[0];
      else if (_list_operand[i] == 'mod')
        _result %= _list_number[0];
      else
        return 'e';

      _list_number.removeAt(0);
    }

    _list_number.clear();
    _list_operand.clear();
    _buffer = '';

    if (_result == _result.toInt())
      return _result.toInt().toString();
    else
      return _result.toString();
  }
}
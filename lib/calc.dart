const operand = ['+', '-', '×', '÷', 'mod'];

class Calculator {
  static var _list_number  = [];
  static var _list_operand = [];
  static var _list         = [];
  static var _buffer       = '';

  static void GetKey(String letter) {
    letter = letter.replaceAll(',', '');
    if (operand.contains(letter)) {
      _list_operand.add(letter);
      _list_number.add(double.parse(_buffer));
      _buffer = '';
      _list.add(letter);
    } else if (letter == 'C') {
      _list_number.clear();
      _list_operand.clear();
      _buffer = '';
      _list.clear();
    } else if (letter == '=') {
      return null;
    } else if (letter == '◀') {
      var last = _list.elementAt(_list.length - 1);
      if (operand.contains(last)) {
        _list.removeLast();
        _list_operand.removeLast();
        _buffer = _list_number.removeLast().toString();
      } else {
        _list.removeLast();
        var revList = _list.reversed;
        var str = '';
        for (int i = 0; i < revList.length; i++) {
          if (!operand.contains(revList.elementAt(i))) {
            str += revList.elementAt(i);
          } else {
            break;
          }
        }
        str = str.split('').reversed.join('');
        _buffer = str;
      }
      // print('===================${last}');
      // print('===================${_list_number}');
      // print('===================${_list_operand}');
      // print('===================${_list}');
      // print('===================${_buffer}');
      // print('?????????????????????????????');
    } else {
      _buffer += letter;
      _list.add(letter);
    }
  }

  static String Execute() {
    var _result = 0.0;
    try {
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
    } catch(e) {
      _list_number.clear();
      _list_operand.clear();
      _buffer = '';
      return '';
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

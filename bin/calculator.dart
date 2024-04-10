import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _expression = '';
  String _result = '';

  void _addToExpression(String text) {
    setState(() {
      _expression += text;
    });
  }

  void _clearExpression() {
    setState(() {
      _expression = '';
      _result = '';
    });
  }

  void _calculateResult() {
    Parser p = Parser();
    Expression exp = p.parse(_expression);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    setState(() {
      _result = eval.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _expression,
              style: TextStyle(fontSize: 24),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _result,
              style: TextStyle(fontSize: 24),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton('7'),
              _buildButton('8'),
              _buildButton('9'),
              _buildButton('/'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton('4'),
              _buildButton('5'),
              _buildButton('6'),
              _buildButton('*'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton('1'),
              _buildButton('2'),
              _buildButton('3'),
              _buildButton('-'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton('0'),
              _buildButton('C'),
              _buildButton('='),
              _buildButton('+'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text) {
    return MaterialButton(
      onPressed: () {
        if (text == 'C') {
          _clearExpression();
        } else if (text == '=') {
          _calculateResult();
        } else {
          _addToExpression(text);
        }
      },
      child: Text(
        text,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      color: Colors.grey[300],
      minWidth: 80,
      height: 80,
    );
  }
}


import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _history = '';
  String _expression = '';

  numclick(String value)
  {
    setState(() {
      if(value == '+' || value == '-' || value == '*' || value == '/' || value == '%')
        {
          var newString = _expression.substring(_expression.length - 1);
          if(newString == '+' || newString == '-' || newString == '*' || newString == '/' || newString == '%')
            value = '';
        }
      if(value == '.')
        {
          if(_expression.contains('.'))
            {
              value = '';
            }
        }
      if(_expression == '')
      {
        if(value == '00')
        {
          value = '0';
        }
      }
      if(_expression == '0')
      {
        if(value == '0' || value == '00')
        {
          value = '';
        }
        else
          {
            if(value != '.')
            {
              _expression = '';
            }
            if(value == '+' || value == '-' || value == '*' || value == '/' || value == '%')
              value = '0';
          }
      }
      _expression += value;
    });
  }

  clear(String text)
  {
    setState(() {
      _expression = '';
      _history = '';
    });
  }
  void calculate(String value)
  {
    Parser p = Parser();
    Expression exp = p.parse(_expression);
    ContextModel cm = ContextModel();
    double result = exp.evaluate(EvaluationType.REAL, cm);

    setState(() {
      var newString = _expression.substring(_expression.length - 1);
      if(newString == '+' || newString == '-' || newString == '*' || newString == '/' || newString == '%')
      {
        _expression = _expression.substring(0, _expression.length - 1);
      }
      if(_expression != '')
      {
        _history = _expression;
        _expression = result.toString();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Container(
        margin: EdgeInsets.all(10),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              width: double.infinity,
              alignment: Alignment.centerRight,
              height: 100,
              child: Text(_history,style: TextStyle(fontSize: 20,color: Colors.grey),),
            ),
            Container(
              padding: EdgeInsets.only(right: 12),
              alignment: Alignment.centerRight,
              width: double.infinity,
              height: 60,
              child: Text(_expression,style: TextStyle(fontSize: 48,fontWeight: FontWeight.bold,color: Colors.white),),
            ),
            SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CalcButton(text: 'C',textcolor: Colors.white,fontsize: 28,fillcolor: Colors.black87,callback: clear ),
                CalcButton(text: '%',textcolor: Colors.white,fontsize: 28,fillcolor: Colors.black87,callback: numclick ),
                CalcButton(textcolor: Colors.white,fontsize: 28,fillcolor: Colors.black87, ),
                CalcButton(text: '/',textcolor: Colors.cyanAccent,fontsize: 28,fillcolor: Colors.black87,callback: numclick ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CalcButton(text: '7',textcolor: Colors.white,fontsize: 28,fillcolor: Colors.black87 ,callback: numclick ),
                CalcButton(text: '8',textcolor: Colors.white,fontsize: 28,fillcolor: Colors.black87 ,callback: numclick ),
                CalcButton(text: '9',textcolor: Colors.white,fontsize: 28,fillcolor: Colors.black87 ,callback: numclick ),
                CalcButton(text: '*',textcolor: Colors.cyanAccent,fontsize: 28,fillcolor: Colors.black87,callback: numclick ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CalcButton(text: '4',textcolor: Colors.white,fontsize: 28,fillcolor: Colors.black87 ,callback: numclick ),
                CalcButton(text: '5',textcolor: Colors.white,fontsize: 28,fillcolor: Colors.black87 ,callback: numclick ),
                CalcButton(text: '6',textcolor: Colors.white,fontsize: 28,fillcolor: Colors.black87 ,callback: numclick ),
                CalcButton(text: '-',textcolor: Colors.cyanAccent,fontsize: 28,fillcolor: Colors.black87,callback: numclick ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CalcButton(text: '1',textcolor: Colors.white,fontsize: 28,fillcolor: Colors.black87,callback: numclick ),
                CalcButton(text: '2',textcolor: Colors.white,fontsize: 28,fillcolor: Colors.black87 ,callback: numclick ),
                CalcButton(text: '3',textcolor: Colors.white,fontsize: 28,fillcolor: Colors.black87 ,callback: numclick ),
                CalcButton(text: '+',textcolor: Colors.cyanAccent,fontsize: 28,fillcolor: Colors.black87,callback: numclick ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CalcButton(text: '00',textcolor: Colors.white,fontsize: 28,fillcolor: Colors.black87,callback: numclick ),
                CalcButton(text: '0',textcolor: Colors.white,fontsize: 28,fillcolor: Colors.black87,callback: numclick ),
                CalcButton(text: '.',textcolor: Colors.white,fontsize: 28,fillcolor: Colors.black87 ,callback: numclick),
                CalcButton(text: '=',textcolor: Colors.cyanAccent,fontsize: 28,fillcolor: Colors.black87 ,callback: calculate),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget CalcButton({String text,Color textcolor,double fontsize,Color fillcolor,Function callback})
  {
    Widget button_widget = Icon(Icons.backspace_outlined,color: Colors.white,);
    if(text != null )
      {
        button_widget = Text(text,style: TextStyle(fontSize: fontsize,fontWeight: FontWeight.bold),);
      }
    return SizedBox(
      width: 70,
      height: 70,
      child: FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50)
          ),
          onPressed: () => { callback (text)},
          color: fillcolor,
          splashColor: Colors.grey.shade500,
          textColor: textcolor,
          child: button_widget
      ),
    );
  }
}

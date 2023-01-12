import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}
class _CalculatorState extends State<Calculator> {
  // String lastInput = "0";
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 35.0;
  double resultFontSize = 45.0;

  buttonPressed(String buttonText){
    setState(() {
      if (buttonText == "C"){
        equation = "0";
        result = "0";
      }else if (buttonText == "<- "){
        equation = equation.substring(0,equation.length - 1);
        if (equation == ""){
          equation = "0";
        }
      }else if (buttonText == "x^2"){
        equation += "^2";
      }else if (buttonText == "="){
        expression = equation;
        expression = expression.replaceAll('x','*');
        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL,cm)}';
        }catch(e){
          result = "Error";
        }

      }else {
        equationFontSize = 45.0;
        resultFontSize = 35.0;
        if (equation == "0"){
          equation = buttonText;
        }else{
          equation = equation + buttonText;
        }
      }
    });

  }
  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: TextButton(
        style: TextButton.styleFrom(backgroundColor: buttonColor),
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 5,
          ),

          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(equation,style: TextStyle(fontSize: equationFontSize)),
          ),

          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(result,style: TextStyle(fontSize: resultFontSize)),
          ),

          const Expanded(
            child: Divider(),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          buildButton("x^2", 1, const Color.fromARGB(255, 89, 150, 255) ),
                          buildButton("<- ", 1, const Color.fromARGB(255, 89, 150, 255) ),
                          buildButton("C", 1, const Color.fromARGB(255, 89, 150, 255) ),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("7", 1, Colors.black ),
                          buildButton("8", 1, Colors.black ),
                          buildButton("9", 1, Colors.black ),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("4", 1, Colors.black ),
                          buildButton("5", 1, Colors.black ),
                          buildButton("6", 1, Colors.black ),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("1", 1, Colors.black ),
                          buildButton("2", 1, Colors.black ),
                          buildButton("3", 1, Colors.black ),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton(".", 1, Colors.black ),
                          buildButton("0", 1, Colors.black ),
                          buildButton("00", 1, Colors.black ),
                        ]
                    )
                  ],
                ),
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          buildButton("/",1,const Color.fromARGB(255, 182, 182, 182)),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("*",1,const Color.fromARGB(255, 182, 182, 182)),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("-",1,const Color.fromARGB(255, 182, 182, 182)),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("+",1,const Color.fromARGB(255, 182, 182, 182)),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("=",1,Color.fromARGB(255, 255, 190, 105)),
                        ]
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
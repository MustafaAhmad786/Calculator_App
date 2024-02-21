import 'package:flutter/material.dart';
import 'package:calculator/color.dart';
import 'package:lottie/lottie.dart';
import 'package:math_expressions/math_expressions.dart';
import 'dart:async';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: splashscreen(),
  ));
}

class splashscreen extends StatefulWidget {
  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 5),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => CalculatorApp(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Calculator App"),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
      ),
      body: Center(
        child: Lottie.asset('assets/anmiation.json'),
      ),
    );
  }
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  //variables
  double firstNum = 0.0;
  double secondNum = 0.0;
  var input = "";
  var output = "";
  var operation = "";
  var HiddenInput = false;
  var outputSize = 28.0;
  var digitsAfterOperator = 0;
  final int maxDigitsAfterOperator = 15;

  onButtonClick(Value) {
    try {
      if (Value == "AC") {
        input = "";
        output = "";
        digitsAfterOperator = 0;
      } else if (Value == "<") {
        if (input.isNotEmpty) {
          input = input.substring(0, input.length - 1);
          if (input.endsWith("+") ||
              input.endsWith("-") ||
              input.endsWith("*") ||
              input.endsWith("/")) {
            digitsAfterOperator = 15;
          }
        }
      } else if (Value == "=") {
        if (input.isNotEmpty) {
          var userInput = input;
          userInput = input.replaceAll("x", "*");
          Parser p = Parser();
          Expression expression = p.parse(userInput);
          ContextModel cm = ContextModel();
          var finalvalue = expression.evaluate(EvaluationType.REAL, cm);
          output = finalvalue.toString();
        }
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
        HiddenInput = true;
        outputSize = 45;
        digitsAfterOperator = 0;
      } else if (Value == "+" || Value == "-" || Value == "*" || Value == "/") {
        input = input + Value;
        digitsAfterOperator = 0;
        HiddenInput = false;
        outputSize = 28;
      } else {
        if (digitsAfterOperator < maxDigitsAfterOperator) {
          input = input + Value;
          HiddenInput = false;
          outputSize = 28;
          digitsAfterOperator++;
        }
      }
    } catch (e) {
      print("Error: $e");
      output = "Error";
      input = "";
      HiddenInput = false;
      outputSize = 28.0;
      digitsAfterOperator = 0;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Calculator App"),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.black,
          ),
          Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        HiddenInput
                            ? ''
                            : input.length > 30
                                ? '' + input.substring(input.length - 30)
                                : input,
                        style: TextStyle(fontSize: 40, color: Colors.white),
                        overflow: TextOverflow.fade, // Add this line
                      ),
                      SizedBox(height: 30),
                      Text(
                        output,
                        style: TextStyle(
                          fontSize: outputSize,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 3,
                        width: double.infinity,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  button(
                    text: "AC",
                    buttonBgColor: operatorColor,
                    tColor: orangeColor,
                  ),
                  button(
                    text: "<",
                    buttonBgColor: operatorColor,
                    tColor: orangeColor,
                  ),
                  button(
                    text: "/",
                    buttonBgColor: operatorColor,
                    tColor: orangeColor,
                  ),
                ],
              ),
              Row(
                children: [
                  button(text: "7"),
                  button(text: "8"),
                  button(text: "9"),
                  button(
                    text: "x",
                    buttonBgColor: operatorColor,
                    tColor: orangeColor,
                  ),
                ],
              ),
              Row(
                children: [
                  button(text: "4"),
                  button(text: "5"),
                  button(text: "6"),
                  button(
                    text: "-",
                    buttonBgColor: operatorColor,
                    tColor: orangeColor,
                  ),
                ],
              ),
              Row(
                children: [
                  button(text: "1"),
                  button(text: "2"),
                  button(text: "3"),
                  button(
                    text: "+",
                    buttonBgColor: operatorColor,
                    tColor: orangeColor,
                  ),
                ],
              ),
              Row(
                children: [
                  button(
                    text: "%",
                    buttonBgColor: operatorColor,
                    tColor: orangeColor,
                  ),
                  
                  button(text: "0"),
                  button(text: "."),
                  button(
                    text: "=",
                    buttonBgColor: orangeColor,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget button({text, tColor = Colors.white, buttonBgColor = buttonColor}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(3),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: buttonBgColor,
            padding: EdgeInsets.all(12),
          ),
          onPressed: () => onButtonClick(text),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: tColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

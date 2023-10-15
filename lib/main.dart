import 'package:flutter/material.dart';
import 'package:calculator/color.dart';
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
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => CalculatorApp())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("calculator App"),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25))),
      ),
      body: Center(
        child: Image.asset('assets/logo.png'),
      ),
    );
  }
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

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
  onButtonClick(Value) {
    try {
      if (Value == "AC") {
        input = "";
        output = "";
      } else if (Value == "<") {
        if (input.isNotEmpty) {
          input = input.substring(0, input.length - 1);
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
      } else {
        input = input + Value;
        HiddenInput = false;
        outputSize = 28;
      }
    } catch (e) {
      // Handle the exception, e.g., display an error message
      print("Error: $e");
      output = "Error";

      // Reset calculator state
      input = "";
      HiddenInput = false;
      outputSize = 28.0;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text("Calculator App"),
          centerTitle: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25))),
        ),
        body: Stack(children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/shah.jpg"),
                fit: BoxFit.cover,
              ),
            ),
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
                      HiddenInput ? '' : input,
                      style: TextStyle(fontSize: 40, color: Colors.white),
                    ),
                    SizedBox(height: 30),
                    Text(
                      output,
                      style: TextStyle(
                          fontSize: outputSize,
                          color: Colors.white.withOpacity(0.7)),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              )),
              Row(
                children: [
                  button(
                      text: "AC",
                      buttonBgColor: operatorColor,
                      tColor: orangeColor),
                  button(
                      text: "<",
                      buttonBgColor: operatorColor,
                      tColor: orangeColor),
                  button(text: "", buttonBgColor: Colors.transparent),
                  button(
                      text: "/",
                      buttonBgColor: operatorColor,
                      tColor: orangeColor),
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
                      tColor: orangeColor),
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
                      tColor: orangeColor),
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
                      tColor: orangeColor),
                ],
              ),
              Row(
                children: [
                  button(
                      text: "%",
                      buttonBgColor: operatorColor,
                      tColor: orangeColor),
                  button(text: "0"),
                  button(text: "."),
                  button(text: "=", buttonBgColor: orangeColor),
                ],
              ),
            ],
          )
        ]));
  }

  Widget button({text, tColor = Colors.white, buttonBgColor = buttonColor}) {
    return Expanded(
        child: Container(
            margin: EdgeInsets.all(3),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    backgroundColor: buttonBgColor,
                    padding: EdgeInsets.all(12)),
                onPressed: () => onButtonClick(text),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 18,
                    color: tColor,
                    fontWeight: FontWeight.bold,
                  ),
                ))));
  }
}

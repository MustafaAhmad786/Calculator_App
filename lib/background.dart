import 'package:flutter/material.dart';

class _CalculatorAppState extends StatelessWidget {
  _CalculatorAppState({super.key});

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
      body: Container(
        child: Stack(children: [Image.asset('assets/shah.jpg')]),
      ),
    );
  }
}

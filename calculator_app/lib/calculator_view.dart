import 'package:flutter/material.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  final _textController = TextEditingController();
  List<String> lstSymbols = [
    "C",
    "*",
    "/",
    "<-",
    "1",
    "2",
    "3",
    "+",
    "4",
    "5",
    "6",
    "-",
    "7",
    "8",
    "9",
    "*",
    "%",
    "0",
    ".",
    "=",
  ];

  final _key = GlobalKey<FormState>();
  String displayText = ""; 
  String previousText = ""; 
  String operation = "";

  void _handleButtonPress(String value) {
    setState(() {
      if (value == "C") {
        displayText = ""; 
      } else if (value == "<-") {
        if (displayText.isNotEmpty) {
          displayText = displayText.substring(0, displayText.length - 1); 
        }
      } else if (value == "=") {
        _evaluateExpression(); 
      } else if (value == "+" || value == "-" || value == "*" || value == "/" || value == "%") {
        if (displayText.isNotEmpty) {
          previousText = displayText; 
          displayText = ""; 
          operation = value; 
        }
      } else {
        displayText += value; 
      }
      _textController.text = displayText; 
    });
  }

  void _evaluateExpression() {
    if (previousText.isNotEmpty && displayText.isNotEmpty && operation.isNotEmpty) {
      double num1 = double.tryParse(previousText) ?? 0.0;
      double num2 = double.tryParse(displayText) ?? 0.0;
      double result;

      switch (operation) {
        case "+":
          result = num1 + num2;
          break;
        case "-":
          result = num1 - num2;
          break;
        case "*":
          result = num1 * num2;
          break;
        case "/":
          result = num2 != 0 ? num1 / num2 : 0.0; 
          break;
        case "%":
          result = num1 % num2;
          break;
        default:
          result = 0.0;
          break;
      }

      displayText = result.toString(); 
      operation = ""; 
      previousText = ""; 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Srijans Calculator App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _key,
          child: Column(
            children: [
              TextFormField(
                textDirection: TextDirection.rtl,
                controller: _textController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
                readOnly: true, 
                textAlign: TextAlign.right, 
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: lstSymbols.length,
                  itemBuilder: (context, index) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      onPressed: () => _handleButtonPress(lstSymbols[index]),
                      child: Text(
                        lstSymbols[index],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
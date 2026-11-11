import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() =>
      _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {

  // Step 4: Declare the Controllers and State Variables
  final firstNumberController = TextEditingController();
  final secondNumberController = TextEditingController();

  // Result variables
  String result = '0';
  String operationLabel = 'Enter two numbers';

  // Step 5: Create the Calculation Function
  void calculate(String operation) {
    final first =
        double.tryParse(firstNumberController.text.trim());

    final second =
        double.tryParse(secondNumberController.text.trim());

    // Check the input
    if (first == null ||
        second == null ||
        !first.isFinite ||
        !second.isFinite) {
      setState(() {
        result = 'Invalid input';
        operationLabel = 'Please enter two valid numbers';
      });
      return;
    }

    // Check division by zero
    if (operation == '÷' && second == 0) {
      setState(() {
        result = 'Cannot divide by zero';
        operationLabel = 'Please change the second number';
      });
      return;
    }

    double answer;

    // Choose the operation
    switch (operation) {
      case '+':
        answer = first + second;
        break;

      case '-':
        answer = first - second;
        break;

      case '×':
        answer = first * second;
        break;

      case '÷':
        answer = first / second;
        break;

      default:
        return;
    }

    // Display the answer
    setState(() {
      result = answer.toString();
      operationLabel = '$first $operation $second';
    });
  }

  // Step 6: Create the Clear Function
  void clearCalculator() {
    firstNumberController.clear();
    secondNumberController.clear();

    setState(() {
      result = '0';
      operationLabel = 'Enter two numbers';
    });
  }

  // Step 7: Release the Controllers
  @override
  void dispose() {
    firstNumberController.dispose();
    secondNumberController.dispose();
    super.dispose();
  }
 // Step 8: Design the Calculator Interface
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // AppBar
      appBar: AppBar(
        title: const Text('My Stateful Calculator'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),

      // Calculator design
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            const SizedBox(height: 10),

            // Calculator icon
            const Icon(
              Icons.calculate,
              size: 64,
              color: Colors.indigo,
            ),

            const SizedBox(height: 12),

            // Title
            const Text(
              'BASIC CALCULATOR',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 24),

            // First number
            TextField(
              controller: firstNumberController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
              decoration: const InputDecoration(
                labelText: 'First Number',
                hintText: 'Enter the first number',
                prefixIcon: Icon(Icons.looks_one),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            // Second number
            TextField(
              controller: secondNumberController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Second Number',
                hintText: 'Enter the second number',
                prefixIcon: Icon(Icons.looks_two),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),

            // Operation buttons
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 12,
              runSpacing: 12,
              children: [

                ElevatedButton(
                  onPressed: () => calculate('+'),
                  child: const Text(
                    '+',
                    style: TextStyle(fontSize: 24),
                  ),
                ),

                ElevatedButton(
                  onPressed: () => calculate('-'),
                  child: const Text(
                    '−',
                    style: TextStyle(fontSize: 24),
                  ),
                ),

                ElevatedButton(
                  onPressed: () => calculate('×'),
                  child: const Text(
                    '×',
                    style: TextStyle(fontSize: 24),
                  ),
                ),

                ElevatedButton(
                  onPressed: () => calculate('÷'),
                  child: const Text(
                    '÷',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Result container
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.indigo,
                ),
              ),
              child: Column(
                children: [

                  Text(
                    operationLabel,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'RESULT',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    result,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Clear button
            OutlinedButton.icon(
              onPressed: clearCalculator,
              icon: const Icon(Icons.refresh),
              label: const Text('Clear'),
            ),

            const SizedBox(height: 24),

            // Student information
            const Text(
              'Created by: Palma, Rachel M.\nSection: CCE106L ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}

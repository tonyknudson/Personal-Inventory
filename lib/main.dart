import 'package:flutter/material.dart';
import 'package:inventory/food_inventory.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    home: FirstRoute(),
  ));
}

class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 135, 202),
        title: const Text('Personal Inventory'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('All Food'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FoodInventory()),
            );
          },
        ),
      ),
    );
  }
}

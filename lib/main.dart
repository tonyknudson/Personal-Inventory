import 'package:flutter/material.dart';
import 'package:inventory/food_inventory.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Personal Inventory',
    home: HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 135, 202),
        title: const Text('Personal Inventory'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          getInfoPanels(),
          const Spacer(),
          getFoodButton(context),
        ],
      ),
    );
  }

  getInfoPanels() {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(),
        Text('Expiring Soon'),
        Spacer(),
        Text('Expired'),
        Spacer(),
      ],
    );
  }

  getFoodButton(context) {
    return Center(
      child: ElevatedButton(
        child: const Text('All Food'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FoodInventory()),
          );
        },
      ),
    );
  }
}

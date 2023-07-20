import 'package:flutter/material.dart';
import 'package:inventory/food_inventory.dart';
import 'package:inventory/segmented_button.dart';

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
          Expanded(flex: 9, child: getInfoPanels(context)),
          const Spacer(),
          Expanded(flex: 1, child: getFoodButton(context)),
        ],
      ),
    );
  }

  getInfoPanels(context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Spacer(),
        Text('We move under cover and we move as one'),
        Text('Through the night, we have one shot to live another day'),
        Text('We cannot let a stray gunshot give us away'),
        Spacer(),
        Text('We will fight up close, seize the moment and stay in it'),
        Text('It’s either that or meet the business end of a bayonet'),
        Text('The code word is ‘Rochambeau,’ dig me?'),
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

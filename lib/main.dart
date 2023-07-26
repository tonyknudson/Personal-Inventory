import 'package:flutter/material.dart';
import 'package:inventory/food_inventory_screen.dart';
import 'package:inventory/segmented_button.dart';
import 'package:inventory/food_category.dart';
import 'package:inventory/config_database_helper.dart';
import 'package:inventory/string_utilities.dart';
import 'package:inventory/category.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Personal Inventory',
    home: HomePage(),
    debugShowCheckedModeBanner: false,
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
          const SizedBox(height: 20),
          const Expanded(flex: 2, child: SegmentedButtonBar()),
          //Expanded(child: ToggleButton()),
          Expanded(flex: 13, child: getItemCardsByExpiration(context)),
          const Spacer(),
          Expanded(flex: 1, child: getFoodButton(context)),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  getItemCardsByExpiration(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        //Spacer(),
        //getCard(),
        Card(
          color: /* index % 2 == 0
              ?*/
              const Color.fromARGB(255, 0, 135, 245),
          //: const Color.fromARGB(255, 0, 135, 255),
          margin: const EdgeInsets.all(15),
          child: ListTile(
              title: Row(
                children: [
                  SizedBox(
                      width: 20,
                      child:
                          FoodCategory.getIcon(Category.fruit, Colors.green)),
                  Text(
                    '${StringUtils.getSpaces(1)}Apple',
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
              subtitle: const Text(
                '3 days',
                style: TextStyle(color: Colors.white),
              ),
              tileColor: const Color.fromARGB(255, 0, 135, 202),
              trailing: const SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.white),
                      onPressed:
                          null, //() => showCustomForm(foodRecord[index]['id']),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.white),
                      onPressed:
                          null, //() => deleteItem(foodRecord[index]['id']),
                    ),
                  ],
                ),
              )),
        ),
        const Spacer(),
        //DELETE ME!!! <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
        SizedBox(
          width: 400,
          child: Row(
            children: [
              FoodCategory.getIcon(Category.frozen),
              FoodCategory.getIcon(Category.meat, Colors.black),
              FoodCategory.getIcon(Category.fruit, Colors.green),
              FoodCategory.getIcon(Category.vegetable, Colors.amber),
              FoodCategory.getIcon(Category.dairy, Colors.red),
              FoodCategory.getIcon(Category.juice, Colors.orange),
              FoodCategory.getIcon(Category.bread, Colors.brown),
              FoodCategory.getIcon(Category.sandwich, Colors.blue),
              FoodCategory.getIcon(null),
            ],
          ),
        ),
//DELETE ME!!! <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

        const Spacer(),
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

  getCard() {
    return (context, index) => Card(
          color: index % 2 == 0
              ? const Color.fromARGB(255, 0, 135, 245)
              : const Color.fromARGB(255, 0, 135, 255),
          margin: const EdgeInsets.all(15),
          child: const ListTile(
              title: Text(/*foodRecord[index][*/ 'title',
                  style: TextStyle(color: Color.fromARGB(255, 216, 216, 216))),
              subtitle: Text(/*foodRecord[index][*/ 'description',
                  style: TextStyle(color: Colors.white)),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed:
                          null, //() => showCustomForm(foodRecord[index]['id']),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed:
                          null, //() => deleteItem(foodRecord[index]['id']),
                    ),
                  ],
                ),
              )),
        );
  }
}

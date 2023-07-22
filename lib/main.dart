import 'package:flutter/material.dart';
import 'package:inventory/food_inventory.dart';
import 'package:inventory/segmented_button.dart';

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
          const Expanded(
              flex: 2,
              child: SizedBox(
                  width: double.maxFinite, child: SegmentedButtonBar())),
          Expanded(flex: 13, child: getItemCardsByExpiration(context)),
          const Spacer(),
          Expanded(flex: 1, child: getFoodButton(context)),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  getItemCardsByExpiration(context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        //Spacer(),
        //getCard(),
        Card(
          color: /* index % 2 == 0
              ?*/
              Color.fromARGB(255, 0, 135, 245),
          //: const Color.fromARGB(255, 0, 135, 255),
          margin: EdgeInsets.all(15),
          child: ListTile(
              title: Text(
                'Apple',
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                '3 days',
                style: TextStyle(color: Colors.white),
              ),
              tileColor: Color.fromARGB(255, 0, 135, 202),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed:
                          null, //() => showCustomForm(myData[index]['id']),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: null, //() => deleteItem(myData[index]['id']),
                    ),
                  ],
                ),
              )),
        ),
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

  getCard() {
    return (context, index) => Card(
          color: index % 2 == 0
              ? const Color.fromARGB(255, 0, 135, 245)
              : const Color.fromARGB(255, 0, 135, 255),
          margin: const EdgeInsets.all(15),
          child: const ListTile(
              title: Text(/*myData[index][*/ 'title',
                  style: TextStyle(color: Color.fromARGB(255, 216, 216, 216))),
              subtitle: Text(/*myData[index][*/ 'description',
                  style: TextStyle(color: Colors.white)),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed:
                          null, //() => showCustomForm(myData[index]['id']),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: null, //() => deleteItem(myData[index]['id']),
                    ),
                  ],
                ),
              )),
        );
  }
}

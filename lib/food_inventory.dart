import 'package:flutter/material.dart';
import 'package:inventory/database_helper.dart';

class FoodInventory extends StatefulWidget {
  const FoodInventory({Key? key}) : super(key: key);

  @override
  _FoodInventoryState createState() => _FoodInventoryState();
}

class _FoodInventoryState extends State<FoodInventory> {
  // All data
  List<Map<String, dynamic>> myData = [];

  bool _isLoading = true;
  // This function is used to fetch all data from the database
  void _refreshData() async {
    final data = await DatabaseHelper.getItems();
    setState(() {
      myData = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshData(); // Loading the data when the app starts
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // This function will be triggered when the floating button is pressed
  // It will also be triggered when you want to update an item
  void showCustomForm(int? id) async {
    if (id != null) {
      // id == null -> create new item
      // id != null -> update an existing item
      final existingData = myData.firstWhere((element) => element['id'] == id);
      _titleController.text = existingData['title'];
      _descriptionController.text = existingData['description'];
    }

    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
              padding: EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                // prevent the soft keyboard from covering the text fields
                bottom: MediaQuery.of(context).viewInsets.bottom + 120,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(hintText: 'Title'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(hintText: 'Description'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // Save new data
                      if (id == null) {
                        await addItem();
                      }

                      if (id != null) {
                        await updateItem(id);
                      }

                      // Clear the text fields
                      _titleController.text = '';
                      _descriptionController.text = '';

                      // Close the bottom sheet
                      Navigator.of(context).pop();
                    },
                    child: Text(id == null ? 'Create New' : 'Update'),
                  )
                ],
              ),
            ));
  }

  // Insert a new data to the database
  Future<void> addItem() async {
    await DatabaseHelper.createItem(
        _titleController.text, _descriptionController.text);
    _refreshData();
  }

  // Update an existing data
  Future<void> updateItem(int id) async {
    await DatabaseHelper.updateItem(
        id, _titleController.text, _descriptionController.text);
    _refreshData();
  }

  // Delete an item
  void deleteItem(int id) async {
    await DatabaseHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Successfully deleted!'), backgroundColor: Colors.green));
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 135, 255),
        title: const Text('Food Inventory'),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(child: loadDataView()),
            Expanded(
              child: loadButtons(),
            ),
          ],
        ),
      ),
    );
  }

  loadDataView() {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : myData.isEmpty
            ? const Center(
                child: Text("Click \"Add Item\" Button",
                    style: TextStyle(color: Colors.white)))
            : ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: myData.length,
                itemBuilder: getCard(),
              );
  }

  loadButtons() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Home'),
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: () => showCustomForm(null),
          child: const Text('Clear'),
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: () => showCustomForm(null),
          child: const Text('Add Custom Item'),
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: () => showCustomForm(null),
          child: const Text('Add Item'),
        ),
        const Spacer(),
      ],
    );
  }

  getCard() {
    return (context, index) => Card(
          color: index % 2 == 0
              ? const Color.fromARGB(255, 0, 135, 245)
              : const Color.fromARGB(255, 0, 135, 255),
          margin: const EdgeInsets.all(15),
          child: ListTile(
              title: Text(myData[index]['title'],
                  style: const TextStyle(
                      color: Color.fromARGB(255, 216, 216, 216))),
              subtitle: Text(myData[index]['description'],
                  style: const TextStyle(color: Colors.white)),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => showCustomForm(myData[index]['id']),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => deleteItem(myData[index]['id']),
                    ),
                  ],
                ),
              )),
        );
  }
}

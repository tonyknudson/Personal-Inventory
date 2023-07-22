import 'package:flutter/material.dart';
import 'package:inventory/database_helper.dart';
import 'package:inventory/clearFoodRecordsDialog.dart';

class FoodInventory extends StatefulWidget {
  const FoodInventory({Key? key}) : super(key: key);

  @override
  _FoodInventoryState createState() => _FoodInventoryState();
}

class _FoodInventoryState extends State<FoodInventory> {
  // All data
  List<Map<String, dynamic>> foodRecord = [];

  bool _isLoading = true;
  // This function is used to fetch all data from the database

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: getAppBar(),
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 10,
              child: loadDataView(),
            ),
//DELETE ME!!! <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
            ElevatedButton(
              onPressed: () => populateTestData(),
              child: const Text('DELETE ME!!!'),
            ),
//DELETE ME!!! <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<)
            Expanded(flex: 1, child: loadButtons()),
          ],
        ),
      ),
    );
  }

  void _refreshData() async {
    final data = await DatabaseHelper.getItems();
    setState(() {
      foodRecord = data;
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
      final existingData =
          foodRecord.firstWhere((element) => element['id'] == id);
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

  //Insert test records into the database
  Future<void> addTestData(title, desc) async {
    await DatabaseHelper.createItem(title, desc);
    _refreshData();
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
        content: Text('Successfully deleted!'), backgroundColor: Colors.blue));
    _refreshData();
  }

  // Delete all items
  void deleteAllItems() async {
    await DatabaseHelper.deleteAllItems();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Successfully deleted all items!'),
        backgroundColor: Colors.blue));
    _refreshData();
  }

  getAppBar() {
    return AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 135, 255),
        title: const Text('Food Inventory'));
  }

  loadDataView() {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : foodRecord.isEmpty
            ? const Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Click \"Add Item\" Button",
                      style: TextStyle(color: Colors.white)),
                ],
              ))
            : Scrollbar(
                child: SizedBox(
                  height: double.maxFinite,
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: foodRecord.length,
                    itemBuilder: getCard(),
                  ),
                ),
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
          onPressed: () => getClearDialog(),
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
              title: Text(foodRecord[index]['title'],
                  style: const TextStyle(
                      color: Color.fromARGB(255, 216, 216, 216))),
              subtitle: Text(foodRecord[index]['description'],
                  style: const TextStyle(color: Colors.white)),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => showCustomForm(foodRecord[index]['id']),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => deleteItem(foodRecord[index]['id']),
                    ),
                  ],
                ),
              )),
        );
  }

  getClearDialog() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.warning),
                  Text('Warning! ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 20),
              const Text('This will delete all of your saved entries'),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      getClearConfirmDialog();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        textStyle: const TextStyle(fontSize: 14)),
                    child: const Text('Delete All'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  getClearConfirmDialog() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        backgroundColor: const Color.fromARGB(255, 255, 145, 0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.warning),
                  Text('Warning! ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 20),
              const Text('This will delete all of your saved entries\n'),
              const Text('This cannot be reversed once completed'),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getClearConfirmButton(),
                  const SizedBox(width: 20),
                  getClearCancelButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  getClearConfirmButton() {
    return ElevatedButton(
      onPressed: () {
        deleteAllItems();
        Navigator.pop(context);
        Navigator.pop(context);
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          textStyle: const TextStyle(fontSize: 14)),
      child: const Text('Delete All'),
    );
  }

  getClearCancelButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
        Navigator.pop(context);
      },
      child: const Text('Cancel'),
    );
  }

  populateTestData() {
    addTestData('Test Title 0', 'Test Desc 0');
    addTestData('Test Title 1', 'Test Desc 1');
    addTestData('Test Title 2', 'Test Desc 2');
    addTestData('Test Title 3', 'Test Desc 3');
    addTestData('Test Title 4', 'Test Desc 4');
  }
}

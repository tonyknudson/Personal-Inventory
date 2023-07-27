import 'package:flutter/material.dart';
import 'package:inventory/food_database_helper.dart';
import 'package:inventory/string_utilities.dart';
import 'package:inventory/food_category.dart';
import 'package:inventory/constants.dart';

class FoodInventory extends StatefulWidget {
  const FoodInventory({Key? key}) : super(key: key);

  @override
  _FoodInventoryState createState() => _FoodInventoryState();
}

class _FoodInventoryState extends State<FoodInventory> {
  // All data
  List<Map<String, dynamic>> foodRecords = [];

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
              child: const Column(
                children: [
                  Text('DELETE ME!!!'),
                ],
              ),
            ),
//DELETE ME!!! <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
            Expanded(flex: 1, child: loadButtons()),
          ],
        ),
      ),
    );
  }

  void _refreshData() async {
    final data = await FoodDatabaseHelper.getFoodRecords();
    setState(() {
      foodRecords = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshData(); // Loading the data when the app starts
  }

  final TextEditingController _labelController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _purchaseDateController = TextEditingController();
  final TextEditingController _expirationDateController =
      TextEditingController();
  final TextEditingController _warningDateController = TextEditingController();

  // This function will be triggered when the floating button is pressed
  // It will also be triggered when you want to update an food record
  void showCustomForm(int? id) async {
    if (id != null) {
      // id == null -> create new food record
      // id != null -> update an existing food record
      final existingData =
          foodRecords.firstWhere((element) => element['id'] == id);
      _labelController.text = existingData['label'];
      _categoryController.text = existingData['category'];
      _purchaseDateController.text = existingData['purchaseDate'];
      _expirationDateController.text = existingData['expirationDate'];
      _warningDateController.text = existingData['warningDate'];
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
                    controller: _labelController,
                    decoration: const InputDecoration(hintText: 'label'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _categoryController,
                    decoration: const InputDecoration(hintText: 'category'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _purchaseDateController,
                    decoration: const InputDecoration(hintText: 'purchaseDate'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _expirationDateController,
                    decoration:
                        const InputDecoration(hintText: 'expirationDate'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _warningDateController,
                    decoration: const InputDecoration(hintText: 'warningDate'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // Save new data
                      if (id == null) {
                        await addFoodRecord();
                      }

                      if (id != null) {
                        await updateFoodRecord(id);
                      }

                      // Clear the text fields
                      _labelController.text = '';
                      _categoryController.text = '';
                      _purchaseDateController.text = '';
                      _expirationDateController.text = '';
                      _warningDateController.text = '';

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
  Future<void> addTestData(
      label, category, purchaseDate, expirationDate, warningDate) async {
    await FoodDatabaseHelper.createFoodRecord(
        label, category, purchaseDate, expirationDate, warningDate);
    _refreshData();
  }

  // Insert a new data to the database
  Future<void> addFoodRecord() async {
    await FoodDatabaseHelper.createFoodRecord(
        _labelController.text,
        _categoryController.text,
        _purchaseDateController.text,
        _expirationDateController.text,
        _warningDateController.text);
    _refreshData();
  }

  // Update an existing data
  Future<void> updateFoodRecord(int id) async {
    await FoodDatabaseHelper.updateFoodRecord(
        id,
        _labelController.text,
        _categoryController.text,
        _purchaseDateController.text,
        _expirationDateController.text,
        _warningDateController.text);
    _refreshData();
  }

  // Delete a food record
  void deleteFoodRecord(int id) async {
    await FoodDatabaseHelper.deleteFoodRecord(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Successfully deleted!'), backgroundColor: Colors.blue));
    _refreshData();
  }

  // Delete all food records
  void deleteAllFoodRecords() async {
    await FoodDatabaseHelper.deleteAllFoodRecords();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Successfully deleted all food records!'),
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
        : foodRecords.isEmpty
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  StringUtils.getBoldPortionMessage(
                      "Click", "\"Add Item\"", "Button",
                      textColor: Colors.white),
                ],
              ))
            : ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: foodRecords.length,
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

  Card Function(dynamic, dynamic) getCard() {
    return (context, index) => Card(
          color: getBackgroundColors(index),
          margin: const EdgeInsets.all(15),
          child: ListTile(
              title: getTitleLine(index),
              subtitle: getSubtitleLine(index),
              trailing: SizedBox(
                width: 100,
                child: getBody(index),
              )),
        );
  }

  Color getBackgroundColors(int index) {
    return index % 2 == 0
        ? const Color.fromARGB(202, 0, 188, 245)
        : const Color.fromARGB(255, 0, 135, 255);
  }

  dynamic getBody(int index) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.edit, color: Colors.white),
          onPressed: () => showCustomForm(foodRecords[index][Constants.ID]),
        ),
        IconButton(
          icon: const Icon(Icons.delete, color: Colors.white),
          onPressed: () => deleteFoodRecord(foodRecords[index][Constants.ID]),
        ),
      ],
    );
  }

  Text getSubtitleLine(index) {
    return Text(
        'Purchased:${StringUtils.getSpaces(1)}${StringUtils.formatDateMdyy(foodRecords[index][Constants.PURCHASE_DATE])}',
        style: const TextStyle(color: Colors.white));
  }

  dynamic getTitleLine(dynamic index) {
    return Row(
      children: [
        const SizedBox(height: 35),
        FoodCategory.getIcon(
            FoodCategory.getCategory(foodRecords[index][Constants.CATEGORY])),
        Text(StringUtils.getSpaces(1) + foodRecords[index][Constants.LABEL],
            style: const TextStyle(color: Color.fromARGB(255, 216, 216, 216))),
      ],
    );
  }

  Future getClearDialog() {
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

  Future getClearConfirmDialog() {
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
              StringUtils.getBoldPortionMessage('This will delete all',
                  foodRecords.length.toString(), 'of your saved entries\n'),
              StringUtils.getBoldPortionMessage(
                  'This', 'cannot be reversed', 'once completed'),
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

  ElevatedButton getClearConfirmButton() {
    return ElevatedButton(
      onPressed: () {
        deleteAllFoodRecords();
        Navigator.pop(context);
        Navigator.pop(context);
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          textStyle: const TextStyle(fontSize: 14)),
      child: const Text('Delete All'),
    );
  }

  ElevatedButton getClearCancelButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
        Navigator.pop(context);
      },
      child: const Text('Cancel'),
    );
  }

  void populateTestData() {
    int i = 0;
    addTestData('Bread ${i++}', 'bread', '20230201', '20210201', '20200201');
    addTestData('Canned ${i++}', 'canned', '20230201', '20210201', '20200201');
    addTestData('Cheese ${i++}', 'cheese', '20230201', '20210201', '20200201');
    addTestData('Dairy ${i++}', 'dairy', '20230201', '20210201', '20200201');
    addTestData('Dried ${i++}', 'dried', '20230201', '20210201', '20200201');
    addTestData('Eggs ${i++}', 'eggs', '20230201', '20210201', '20200201');
    addTestData('Fruit ${i++}', 'fruit', '20230201', '20210201', '20200201');
    addTestData('Frozen ${i++}', 'frozen', '20230201', '20210201', '20200201');
    addTestData('Juice ${i++}', 'juice', '20230201', '20210201', '20200201');
    addTestData('Meat ${i++}', 'meat', '20230201', '20210201', '20200201');
    addTestData('Milk ${i++}', 'milk', '20230201', '20210201', '20200201');
    addTestData(
        'Sandwich ${i++}', 'sandwich', '20230201', '20210201', '20200201');
    addTestData('Shelf ${i++}', 'shelf', '20230201', '20210201', '20200201');
    addTestData(
        'Vegetable ${i++}', 'vegetable', '20230201', '20210201', '20200201');
    addTestData(
        'Unknown ${i++}', 'bad_data', '20230201', '20210201', '20200201');
  }
}

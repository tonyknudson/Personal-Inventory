import 'package:flutter/material.dart';
import 'package:inventory/category.dart';

const String breadIcon = 'assets/images/bread.ico';
const String cannedIcon = 'assets/images/canned.ico';
const String cheeseIcon = 'assets/images/cheese.ico';
const String dairyIcon = 'assets/images/dairy.ico';
const String driedIcon = 'assets/images/dried.ico';
const String defaultIcon = 'assets/images/cutlery.ico';
const String eggsIcon = 'assets/images/egg.ico';
const String fruitIcon = 'assets/images/apple.ico';
const String frozenIcon = 'assets/images/bag.ico';
const String juiceIcon = 'assets/images/juice.ico';
const String meatIcon = 'assets/images/meat.ico';
const String milkIcon = 'assets/images/milk.ico';
const String shelfIcon = 'assets/images/jar.ico';
const String sandwichIcon = 'assets/images/sandwich.ico';
const String vegetableIcon = 'assets/images/brocolli.ico';

/*
cheese 1 month
milk 2 weeks
eggs 3 weeks
shelf 1 yr
dryGoods 5 yrs
canned 2-3 yrs
*/
class FoodCategory {
  static final Map<Category, AssetImage> _categoryIcons = {
    Category.bread: const AssetImage(breadIcon),
    Category.canned: const AssetImage(cannedIcon),
    Category.cheese: const AssetImage(cheeseIcon),
    Category.dairy: const AssetImage(dairyIcon),
    Category.dried: const AssetImage(driedIcon),
    Category.eggs: const AssetImage(eggsIcon),
    Category.fruit: const AssetImage(fruitIcon),
    Category.frozen: const AssetImage(frozenIcon),
    Category.juice: const AssetImage(juiceIcon),
    Category.meat: const AssetImage(meatIcon),
    Category.milk: const AssetImage(milkIcon),
    Category.sandwich: const AssetImage(sandwichIcon),
    Category.shelf: const AssetImage(shelfIcon),
    Category.vegetable: const AssetImage(vegetableIcon),
    Category.unknown: const AssetImage(defaultIcon),
  };

  static ImageIcon getIcon(Category category,
      [Color iconColor = Colors.white]) {
    final imageAsset = _categoryIcons[category] ?? AssetImage(defaultIcon);
    return ImageIcon(imageAsset, color: iconColor);
  }

  static final Map<String, Category> _categoryMap = {
    'bread': Category.bread,
    'canned': Category.canned,
    'cheese': Category.cheese,
    'dairy': Category.dairy,
    'dried': Category.dried,
    'eggs': Category.eggs,
    'fruit': Category.fruit,
    'frozen': Category.frozen,
    'juice': Category.juice,
    'meat': Category.meat,
    'milk': Category.milk,
    'sandwich': Category.sandwich,
    'shelf': Category.shelf,
    'vegetable': Category.vegetable,
  };

  static Category getCategory(String cat) {
    return _categoryMap[cat.toLowerCase()] ?? Category.unknown;
  }
}

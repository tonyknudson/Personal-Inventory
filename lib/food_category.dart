import 'package:flutter/material.dart';
import 'package:inventory/category.dart';

const String breadIcon = 'assets/images/bread.ico';
const String dairyIcon = 'assets/images/dairy.ico';
const String defaultIcon = 'assets/images/cutlery.ico';
const String fruitIcon = 'assets/images/apple.ico';
const String frozenIcon = 'assets/images/bag.ico';
const String juiceIcon = 'assets/images/juice.ico';
const String meatIcon = 'assets/images/steak3.ico';
const String sandwichIcon = 'assets/images/sandwich.ico';
const String vegetableIcon = 'assets/images/brocolli.ico';

class FoodCategory {
  static ImageIcon getIcon(category, [iconColor]) {
    iconColor = iconColor ?? Colors.white;

    switch (category) {
      case Category.fruit:
        return ImageIcon(const AssetImage(fruitIcon), color: iconColor);
      case Category.vegetable:
        return ImageIcon(const AssetImage(vegetableIcon), color: iconColor);
      case Category.meat:
        return ImageIcon(const AssetImage(meatIcon), color: iconColor);
      case Category.frozen:
        return ImageIcon(const AssetImage(frozenIcon), color: iconColor);
      case Category.juice:
        return ImageIcon(const AssetImage(juiceIcon), color: iconColor);
      case Category.dairy:
        return ImageIcon(const AssetImage(dairyIcon), color: iconColor);
      case Category.bread:
        return ImageIcon(const AssetImage(breadIcon), color: iconColor);
      case Category.sandwich:
        return ImageIcon(const AssetImage(sandwichIcon), color: iconColor);
      default:
        return ImageIcon(const AssetImage(defaultIcon), color: iconColor);
    }
  }
}

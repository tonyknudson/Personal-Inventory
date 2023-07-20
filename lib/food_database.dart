import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Food {
  final int indx;
  final String label;
  final String category;
  final DateTime purchaseDate;
  final DateTime warningDate;
  final DateTime tossDate;

  const Food({
    required this.indx,
    required this.label,
    required this.category,
    required this.purchaseDate,
    required this.warningDate,
    required this.tossDate,
  });
}
